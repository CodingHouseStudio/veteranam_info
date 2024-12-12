import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/components/discounts/discounts.dart';
import 'package:veteranam/shared/shared_flutter.dart';

extension LinkScrollExtension on DiscountConfigState {
  int get linkInt => (linkScrollCount + 1) * loadingItems;
}

class DiscountsDeskWidgetList extends MultiChildRenderObjectWidget {
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
            final totalCount = state.filteredDiscountModelItems.length;
            final linkIndex = config.linkInt - 1;
            final showLink = linkIndex >= 0 && linkIndex < totalCount;
            final itemsBeforeLink = showLink ? linkIndex : totalCount;
            final itemsAfterLink = showLink ? totalCount - linkIndex : 0;
            return SliverMainAxisGroup(
              slivers: [
                if (itemsBeforeLink > 0)
                  SliverPrototypeExtentList.builder(
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
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
                    itemCount: itemsBeforeLink,
                    itemBuilder: (context, index) {
                      final discountItem =
                          state.filteredDiscountModelItems.elementAt(index);
                      return Padding(
                        key: ValueKey(discountItem.id),
                        padding: const EdgeInsets.only(
                          top: KPadding.kPaddingSize48,
                        ),
                        child: DiscountCardWidget(
                          discountItem: discountItem,
                          isDesk: isDesk,
                          share:
                              '${KRoute.home.path}${KRoute.discounts.path}/${discountItem.id}',
                        ),
                      );
                    },
                  ),
                if (showLink)
                  SliverToBoxAdapter(
                    key: const ValueKey('link_field'),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: KPadding.kPaddingSize48,
                      ),
                      child: DiscountLinkWidget(isDesk: isDesk),
                    ),
                  ),
                if (itemsAfterLink > 0)
                  SliverPrototypeExtentList.builder(
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
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
                    itemCount: itemsAfterLink,
                    itemBuilder: (context, index) {
                      final discountIndex = linkIndex + index;
                      final discountItem = state.filteredDiscountModelItems
                          .elementAt(discountIndex);
                      return Padding(
                        key: ValueKey(discountItem.id),
                        padding: const EdgeInsets.only(
                          top: KPadding.kPaddingSize48,
                        ),
                        child: DiscountCardWidget(
                          discountItem: discountItem,
                          isDesk: isDesk,
                          share:
                              '${KRoute.home.path}${KRoute.discounts.path}/${discountItem.id}',
                        ),
                      );
                    },
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
