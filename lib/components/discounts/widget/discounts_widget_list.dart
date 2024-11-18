import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/components/discounts/discounts.dart';
import 'package:veteranam/shared/shared_flutter.dart';

// class DiscountsWidgetList extends SingleChildRenderObjectWidget {
//   const DiscountsWidgetList({
//     required this.isDesk,
//     super.key,
//   });
//   final bool isDesk;

//   @override
//   MultiChildRenderObjectWidget createRenderObject(BuildContext context) {
//     if (isDesk) {
//       return _DiscountsDeskWidgetList();
//     } else {
//       return  _DiscountsMobWidgetList();
//     }
//   }
// }

int _itemCount({
  required DiscountWatcherState state,
  required DiscountConfigState config,
}) =>
    state.filteredDiscountModelItems.isEmpty
        ? config.loadingItems
        : state.filteredDiscountModelItems.length +
            ((state.loadingStatus == LoadingStatus.loaded &&
                        PlatformEnumFlutter.isWebDesktop) ||
                    state.loadingStatus == LoadingStatus.listLoadedFull
                ? 1
                : KDimensions.shimmerDiscountsItems) +
            ((config.linkScrollCount + 1) * config.loadingItems >
                    state.filteredDiscountModelItems.length
                ? 0
                : 1);

/// The findChildIndexCallback method is called whenever the list is rebuilt.
/// Initially, it returns the old keys of the list items. If an item remains
/// in the updated list, assigning it a new index helps optimize the list's
/// performance, especially in scenarios with filtering or dynamic content
/// changes. This prevents unnecessary removal and recreation of widgets.
/// Note:
/// These are based on my experience working with this method and ChatGPT's
/// response. I need to read more articles to understand all the nuances.

int? _findChildIndexCallback({
  required Key key,
  required DiscountWatcherState state,
}) {
  if (key is ValueKey<String>) {
    final valueKey = key;
    if (valueKey.value.contains('end_list_text')) {
      return state.filteredDiscountModelItems.length;
    }
    if (valueKey.value.contains('load_button')) {
      return state.filteredDiscountModelItems.length;
    }
    if (!valueKey.value.contains('mock_discount_')) {
      final index = state.filteredDiscountModelItems.indexWhere(
        (element) => element.id == valueKey.value,
      );
      if (index >= 0) {
        return index;
      }
    } else {
      final mockValue = int.tryParse(
        valueKey.value.replaceAll('mock_discount_', ''),
      );
      if (mockValue != null) {
        return state.filteredDiscountModelItems.length + mockValue;
      }
    }
  }
  return null;
}

ValueKey<String> _key({
  required DiscountWatcherState state,
  required int index,
}) {
  if (index < state.filteredDiscountModelItems.length) {
    return ValueKey(state.filteredDiscountModelItems.elementAt(index).id);
  }
  if (state.loadingStatus == LoadingStatus.listLoadedFull) {
    return const ValueKey('end_list_text');
  }
  if (state.loadingStatus == LoadingStatus.loaded &&
      PlatformEnumFlutter.isWebDesktop) {
    return const ValueKey('load_button');
  }
  return ValueKey(
    'mock_discount_'
    '${index + 2 - state.filteredDiscountModelItems.length}',
  );
}

class DiscountsDeskWidgetList extends MultiChildRenderObjectWidget {
  // Constructor for the RowSliver widget
  DiscountsDeskWidgetList({
    required this.maxHeight,
    super.key,
  }) : super(
          children: [
            _AdvancedFilterDesk(
              maxHeight: maxHeight,
            ),
            const _DiscountWidgetList(
              isDesk: true,
            ),
          ],
        );
  final double maxHeight;

  // Creates the render object for this widget
  @override
  RenderRowSliver createRenderObject(BuildContext context) {
    return RenderRowSliver(leftWidthPercent: 0.3);
  }
}

class _AdvancedFilterDesk extends StatelessWidget {
  const _AdvancedFilterDesk({
    required this.maxHeight,
  });
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverHeaderWidget(
        // isDesk: isDesk,
        childWidget: ({
          required overlapsContent,
          required shrinkOffset,
        }) =>
            const AdvancedFilterDesk(),
        maxMinHeight: maxHeight,
        // isTablet: isTablet,
      ),
    );
  }
}

class DiscountsMobWidgetList extends SingleChildRenderObjectWidget {
  const DiscountsMobWidgetList({required this.padding, super.key})
      : super(
          child: const _DiscountWidgetList(
            isDesk: false,
          ),
        );
  final EdgeInsets padding;
  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderSliverPadding(
      padding: padding,
      textDirection: Directionality.of(context),
    );
  }
}

class _DiscountWidgetList extends StatelessWidget {
  const _DiscountWidgetList({required this.isDesk});
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscountConfigCubit, DiscountConfigState>(
      builder: (context, config) {
        return BlocBuilder<DiscountWatcherBloc, DiscountWatcherState>(
          buildWhen: (previous, current) =>
              previous.loadingStatus != current.loadingStatus ||
              previous.filteredDiscountModelItems !=
                  current.filteredDiscountModelItems,
          builder: (context, state) {
            return SliverList.builder(
              addAutomaticKeepAlives: false,
              addRepaintBoundaries: false,
              findChildIndexCallback: (key) =>
                  _findChildIndexCallback(key: key, state: state),
              itemCount: _itemCount(
                state: state,
                config: config,
              ),
              itemBuilder: (context, index) => _DiscountsWidgetItem(
                isDesk: isDesk,
                key: _key(state: state, index: index),
                state: state,
                index: index,
                config: config,
              ),
            );
          },
        );
      },
    );
  }
}

class _DiscountsWidgetItem extends StatelessWidget {
  const _DiscountsWidgetItem({
    required this.state,
    required this.index,
    required this.config,
    required this.isDesk,
    super.key,
  });
  final bool isDesk;
  final DiscountWatcherState state;
  final int index;
  final DiscountConfigState config;
  @override
  Widget build(BuildContext context) {
    var indexValue = index;
    if ((config.linkScrollCount + 1) * config.loadingItems <= index + 1) {
      if ((config.linkScrollCount + 1) * config.loadingItems == index + 1) {
        return DiscountLinkWidget(isDesk: isDesk);
      }
      indexValue--;
    }
    if (indexValue < state.filteredDiscountModelItems.length) {
      final discountItem =
          state.filteredDiscountModelItems.elementAt(indexValue);
      return Padding(
        padding: const EdgeInsets.only(
          top: KPadding.kPaddingSize48,
        ),
        child: DiscountCardWidget(
          discountItem: discountItem,
          isDesk: isDesk,
          // reportEvent: null,
          share:
              '${KRoute.home.path}${KRoute.discounts.path}/${discountItem.id}',
          isLoading: false,
          // () => context
          //     .read<DiscountWatcherBloc>()
          //     .add(const DiscountWatcherEvent.getReport()),
        ),
      );
    } else {
      if (state.loadingStatus == LoadingStatus.listLoadedFull) {
        return Padding(
          padding: const EdgeInsets.only(
            top: KPadding.kPaddingSize48,
          ),
          child: Center(
            child: Text(
              context.l10n.thatEndOfList,
              key: KWidgetkeys.screen.investors.endListText,
              style: AppTextStyle.materialThemeTitleMediumNeutralVariant70,
            ),
          ),
        );
      }
      if (state.loadingStatus == LoadingStatus.loaded &&
          PlatformEnumFlutter.isWebDesktop) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: KPadding.kPaddingSize48,
          ),
          child: LoadingButtonWidget(
            widgetKey: KWidgetkeys.widget.scaffold.loadingButton,
            text: context.l10n.moreDiscounts,
            onPressed: () => context.read<DiscountWatcherBloc>().add(
                  const DiscountWatcherEvent.loadNextItems(),
                ),
            isDesk: isDesk,
          ),
        );
      }
      return Padding(
        padding: const EdgeInsets.only(
          top: KPadding.kPaddingSize48,
        ),
        child: SkeletonizerWidget(
          isLoading: true,
          child: DiscountCardWidget(
            key: KWidgetkeys.screen.discounts.card,
            discountItem: KMockText.discountModel,
            isDesk: isDesk,
            share: '',
            isLoading: true,
          ),
        ),
      );
    }
  }
}
// List<Widget> discountsWidgetList({
//   required BuildContext context,
//   required bool isDesk,
// }) {
//   final items = cardWidgetList<DiscountModel>(
//     loadingStatus: context.read<DiscountWatcherBloc>().state.loadingStatus,
//     modelItems:
//         context.read<DiscountWatcherBloc>().state.filteredDiscountModelItems,
//     cardWidget: ({required modelItem, required isLoading}) =>
//         DiscountCardWidget(
//       key: KWidgetkeys.screen.discounts.card,
//       discountItem: modelItem,
//       isDesk: isDesk,
//       // reportEvent: null,
//       share: '${KRoute.home.path}${KRoute.discounts.path}/${modelItem.id}',
//       isLoading: isLoading,
//       // () => context
//       //     .read<DiscountWatcherBloc>()
//       //     .add(const DiscountWatcherEvent.getReport()),
//     ),
//     isDesk: isDesk,
//   shimmerItemsNumber: context.read<DiscountConfigCubit>().state.loadingItems,
//     isNotFailure: context.read<DiscountWatcherBloc>().state.failure == null,
//     shimmerItem: KMockText.discountModel,
//   );

//   final finalList = <Widget>[];
//   for (var i = 0; i < items.length; i++) {
//     finalList.add(items[i]);
//     if ((context.read<DiscountConfigCubit>().state.linkScrollCount + 1) *
//             context.read<DiscountConfigCubit>().state.loadingItems ==
//         i + 1) {
//       finalList.add(
//         DiscountLinkWidget(isDesk: isDesk),
//       );
//     }
//   }
//   return finalList;
// }
