import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/components/discounts/discounts.dart';
import 'package:veteranam/shared/shared_flutter.dart';

int _itemCount({
  required DiscountWatcherState state,
  required DiscountConfigState config,
}) =>
    state.filteredDiscountModelItems.length +
    (config.linkInt >= state.filteredDiscountModelItems.length ? 0 : 1);

extension LinkScrollExtension on DiscountConfigState {
  int get linkInt => (linkScrollCount + 1) * loadingItems;
}

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
  required DiscountConfigState config,
}) {
  if (key is ValueKey<String>) {
    final valueKey = key;
    if (valueKey.value == 'link_field') {
      return config.linkInt - 1;
    }
    final index = state.filteredDiscountModelItems.indexWhere(
      (element) => element.id == valueKey.value,
    );
    if (index >= 0) {
      return index + (config.linkInt <= index ? 1 : 0);
    }
  }
  return null;
}

ValueKey<String> _key({
  required DiscountWatcherState state,
  required int index,
  required DiscountConfigState config,
}) {
  if (index + 1 == config.linkInt) {
    return const ValueKey('link_field');
  }
  return ValueKey(
    state.filteredDiscountModelItems
        .elementAt(index - (config.linkInt <= index ? 1 : 0))
        .id,
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
    return RenderRowSliver(leftWidthPercent: 1 / 3);
  }
}

class _AdvancedFilterDesk extends StatelessWidget {
  const _AdvancedFilterDesk({
    required this.maxHeight,
  });
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(
        top: KPadding.kPaddingSize48,
      ),
      sliver: SliverPersistentHeader(
        pinned: true,
        delegate: SliverHeaderWidget(
          childWidget: ({
            required overlapsContent,
            required shrinkOffset,
          }) =>
              const AdvancedFilterDesk(),
          maxMinHeight: maxHeight,
        ),
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
            return SliverMainAxisGroup(
              slivers: [
                SliverList.builder(
                  addAutomaticKeepAlives: false,
                  addRepaintBoundaries: false,
                  findChildIndexCallback: (key) => _findChildIndexCallback(
                    key: key,
                    state: state,
                    config: config,
                  ),
                  itemCount: _itemCount(
                    state: state,
                    config: config,
                  ),
                  itemBuilder: (context, index) => Padding(
                    key: _key(state: state, index: index, config: config),
                    padding: const EdgeInsets.only(
                      top: KPadding.kPaddingSize48,
                    ),
                    child: _DiscountsWidgetItem(
                      isDesk: isDesk,
                      key: _key(state: state, index: index, config: config),
                      state: state,
                      index: index,
                      config: config,
                    ),
                  ),
                ),
                if ((!PlatformEnumFlutter.isWebDesktop &&
                        state.loadingStatus != LoadingStatus.listLoadedFull) ||
                    state.discountModelItems.isEmpty)
                  SliverPrototypeExtentList.builder(
                    itemCount: state.filteredDiscountModelItems.isEmpty
                        ? config.loadingItems
                        : KDimensions.shimmerDiscountsItems,
                    prototypeItem: Padding(
                      padding: const EdgeInsets.only(
                        top: KPadding.kPaddingSize48,
                      ),
                      child: SkeletonizerWidget(
                        isLoading: false,
                        child: DiscountCardWidget(
                          key: KWidgetkeys.screen.discounts.card,
                          discountItem: KMockText.discountModel,
                          isDesk: isDesk,
                          share: '',
                        ),
                      ),
                    ),
                    itemBuilder: (context, index) => Padding(
                      key: const ValueKey('discount_mock_card'),
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
                        ),
                      ),
                    ),
                  )
                else if (state.loadingStatus == LoadingStatus.listLoadedFull)
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      vertical: KPadding.kPaddingSize48,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          context.l10n.thatEndOfList,
                          key: KWidgetkeys.screen.investors.endListText,
                          style: AppTextStyle
                              .materialThemeTitleMediumNeutralVariant70,
                        ),
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      vertical: KPadding.kPaddingSize48,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: LoadingButtonWidget(
                        widgetKey: KWidgetkeys.widget.scaffold.loadingButton,
                        text: context.l10n.moreDiscounts,
                        onPressed: () =>
                            context.read<DiscountWatcherBloc>().add(
                                  const DiscountWatcherEvent.loadNextItems(),
                                ),
                        isDesk: isDesk,
                      ),
                    ),
                  ),
              ],
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

    if (config.linkInt <= index &&
        state.filteredDiscountModelItems.length > config.linkInt) {
      indexValue--;
    }
    if (config.linkInt == index + 1) {
      return DiscountLinkWidget(isDesk: isDesk);
    }
    final discountItem = state.filteredDiscountModelItems.elementAt(indexValue);
    return DiscountCardWidget(
      discountItem: discountItem,
      isDesk: isDesk,
      share: '${KRoute.home.path}${KRoute.discounts.path}/${discountItem.id}',
    );
  }
}
