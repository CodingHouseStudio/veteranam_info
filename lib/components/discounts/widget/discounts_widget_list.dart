import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/components/discounts/discounts.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountsWidgetList extends StatelessWidget {
  const DiscountsWidgetList({
    required this.isDesk,
    super.key,
  });
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    if (isDesk) {
      return const _DiscountsDeskWidgetList();
    } else {
      return const _DiscountsMobWidgetList();
    }
  }
}

int _itemCount(DiscountWatcherState state) =>
    state.filteredDiscountModelItems.length +
    ((state.loadingStatus == LoadingStatus.loaded &&
                PlatformEnumFlutter.isWebDesktop) ||
            state.loadingStatus == LoadingStatus.listLoadedFull
        ? 1
        : KDimensions.shimmerDiscountsItems);

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
      return _itemCount(state) - 1;
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
    '${index + 1 - state.filteredDiscountModelItems.length}',
  );
}

class _DiscountsDeskWidgetList extends StatelessWidget {
  const _DiscountsDeskWidgetList();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      primary: false,
      shrinkWrap: true,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      slivers: [
        RowSliver(
          right: BlocBuilder<DiscountConfigCubit, DiscountConfigState>(
            builder: (context, config) {
              return BlocBuilder<DiscountWatcherBloc, DiscountWatcherState>(
                buildWhen: (previous, current) =>
                    previous.loadingStatus != current.loadingStatus ||
                    previous.filteredDiscountModelItems !=
                        current.filteredDiscountModelItems,
                builder: (context, state) {
                  return SliverList.builder(
                    itemCount: _itemCount(state),
                    findChildIndexCallback: (key) =>
                        _findChildIndexCallback(key: key, state: state),
                    itemBuilder: (context, index) => _DiscountsWidgetItem(
                      isDesk: true,
                      key: _key(state: state, index: index),
                      state: state,
                      index: index,
                      config: config,
                      context: context,
                    ),
                  );
                },
              );
            },
          ),
          left: const SliverToBoxAdapter(
            child: AdvancedFilterDesk(),
          ),
          leftWidthPercent: 0.3,
        ),
      ],
    );
  }
}

class _DiscountsMobWidgetList extends StatelessWidget {
  const _DiscountsMobWidgetList();

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
            return ListView.builder(
              primary: false,
              addAutomaticKeepAlives: false,
              addRepaintBoundaries: false,
              shrinkWrap: true,
              restorationId: 'discount_list',
              findChildIndexCallback: (key) =>
                  _findChildIndexCallback(key: key, state: state),
              itemCount: _itemCount(state),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemBuilder: (context, index) => _DiscountsWidgetItem(
                isDesk: false,
                key: _key(state: state, index: index),
                state: state,
                index: index,
                config: config,
                context: context,
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
    required this.context,
    required this.isDesk,
    super.key,
  });
  final bool isDesk;
  final DiscountWatcherState state;
  final int index;
  final DiscountConfigState config;
  final BuildContext context;
  @override
  Widget build(BuildContext context) {
    if (index < state.filteredDiscountModelItems.length) {
      final discountItem = state.filteredDiscountModelItems.elementAt(index);
      if ((config.linkScrollCount + 1) * config.loadingItems == index + 1) {
        return ListView(
          primary: false,
          padding: const EdgeInsets.only(
            top: KPadding.kPaddingSize48,
          ),
          shrinkWrap: true,
          children: [
            DiscountCardWidget(
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
            DiscountLinkWidget(isDesk: isDesk),
          ],
        );
      } else {
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
      }
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
          padding: const EdgeInsets.only(
            top: KPadding.kPaddingSize48,
          ),
          child: LoadingButtonWidget(
            widgetKey: KWidgetkeys.screen.discounts.button,
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
