import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/components/discounts/discounts.dart';
import 'package:veteranam/shared/shared_flutter.dart';

int _itemCount({
  required List<DiscountModel> filterDiscountModelList,
  required DiscountConfigState config,
}) =>
    filterDiscountModelList.length +
    (config.linkInt >= filterDiscountModelList.length ? 0 : 1);

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
  required List<DiscountModel> filterDiscountModelList,
  required DiscountConfigState config,
}) {
  final int? index;
  if (key is ValueKey<String>) {
    final valueKey = key;
    if (valueKey.value == 'link_field') {
      index = config.linkInt - 1;
    } else {
      final indexValue = filterDiscountModelList.indexWhere(
        (element) => element.id == valueKey.value,
      );
      if (indexValue >= 0) {
        index = indexValue + (config.linkInt <= indexValue ? 1 : 0);
      } else {
        index = null;
      }
    }
  } else {
    index = null;
  }
  return index != null ? (index * 2) : null;
}

ValueKey<String> _key({
  required List<DiscountModel> filterDiscountModelList,
  required int index,
  required DiscountConfigState config,
}) {
  if (index + 1 == config.linkInt) {
    return const ValueKey('link_field');
  }
  return ValueKey(
    filterDiscountModelList
        .elementAt(index - (config.linkInt <= index ? 1 : 0))
        .id,
  );
}

// class DiscountsDeskWidgetList extends StatelessWidget {
//   const DiscountsDeskWidgetList({required this.maxHeight, super.key});
//   final double maxHeight;
//   @override
//   Widget build(BuildContext context) {
//     return SliverCrossAxisGroup(
//       slivers: [
//         SliverCrossAxisExpanded(
//           flex: 1,
//           sliver: _AdvancedFilterDesk(
//             maxHeight: maxHeight,
//           ),
//         ),
//         const SliverCrossAxisExpanded(
//           flex: 2,
//           sliver: _DiscountWidgetList(
//             isDesk: true,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class DiscountsDeskWidgetList extends MultiChildRenderObjectWidget {
//   // Constructor for the RowSliver widget
//   DiscountsDeskWidgetList({
//     required this.maxHeight,
//     super.key,
//   }) : super(
//           children: [
//             _AdvancedFilterDesk(
//               maxHeight: maxHeight,
//             ),
//             const _DiscountWidgetList(
//               isDesk: true,
//             ),
//           ],
//         );
//   final double maxHeight;

//   // Creates the render object for this widget
//   @override
//   RenderRowSliver createRenderObject(BuildContext context) {
//     return RenderRowSliver(leftWidthPercent: 1 / 3);
//   }
// }

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
        childWidget: ({
          required overlapsContent,
          required shrinkOffset,
        }) =>
            const SizedBox(
          height: double.infinity,
          child: AdvancedFilterContent(
            key: DiscountsFilterKeys.desk,
            isDesk: true,
          ),
        ),
        maxMinHeight: maxHeight,
      ),
    );
  }
}

class DiscountsMobWidgetList extends SingleChildRenderObjectWidget {
  DiscountsMobWidgetList({
    required this.padding,
    required this.isDesk,
    super.key,
  }) : super(
          child: _DiscountWidgetList(
            isDesk: isDesk,
          ),
        );
  final EdgeInsets padding;
  final bool isDesk;
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
        return SliverMainAxisGroup(
          slivers: [
            BlocSelector<DiscountsWatcherBloc, DiscountsWatcherState,
                List<DiscountModel>>(
              selector: (state) {
                return state.filterDiscountModelList;
              },
              builder: (context, filterDiscountModelList) {
                if (Config.isWeb && isDesk) {
                  return BlocBuilder<ViewModeCubit, ViewMode>(
                    builder: (context, _) {
                      switch (_) {
                        case ViewMode.grid:
                          return SliverMasonryGrid(
                            key: DiscountsKeys.horizontalList,
                            crossAxisSpacing: KPadding.kPaddingSize24,
                            mainAxisSpacing: KPadding.kPaddingSize24,
                            gridDelegate:
                                // ignore: lines_longer_than_80_chars
                                const SliverSimpleGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: KSize.kPixel500,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final discount =
                                    filterDiscountModelList.elementAt(index);
                                return DiscountCardWidget(
                                  key: ValueKey(discount.id),
                                  discountItem: discount,
                                  isDesk: false,
                                  share:
                                      '${KRoute.home.path}${KRoute.discounts.path}/${discount.id}',
                                  dialogIsDesk: true,
                                );
                              },
                              childCount: filterDiscountModelList.length,
                              // findChildIndexCallback: (key) =>
                              //     _findChildIndexCallback(
                              //   key: key,
                              //   filterDiscountModelList:
                              //       filterDiscountModelList,
                              //   config: config,
                              // ),
                            ),
                          );
                        case ViewMode.list:
                          return DiscountsSliverList(
                            key: DiscountsKeys.verticalList,
                            isDesk: isDesk,
                            filterDiscountModelList: filterDiscountModelList,
                            config: config,
                          );
                      }
                    },
                  );
                } else {
                  return DiscountsSliverList(
                    isDesk: isDesk,
                    filterDiscountModelList: filterDiscountModelList,
                    config: config,
                  );
                }
              },
            ),
            BlocSelector<
                DiscountsWatcherBloc,
                DiscountsWatcherState,
                ({
                  // LoadingStatus loadingStatus,
                  // List<DiscountModel> filterDiscountModelList,
                  bool isListLoadedFull,
                  bool unmodifiedIsEmpty,
                  bool isFilterListEmpty,
                })>(
              // buildWhen: (previous, current) =>
              //     previous.loadingStatus != current.loadingStatus ||
              //     previous.filterDiscountModelList !=
              //         current.filterDiscountModelList,
              selector: (state) => (
                // loadingStatus: state.loadingStatus,
                // filterDiscountModelList: state.filterDiscountModelList,
                isListLoadedFull: state.isListLoadedFull &&
                    state.unmodifiedDiscountModelItems.isNotEmpty,
                unmodifiedIsEmpty: state.unmodifiedDiscountModelItems.isEmpty,
                isFilterListEmpty: state.filterDiscountModelList.isEmpty,
              ),
              builder: (context, state) {
                return SliverMainAxisGroup(
                  slivers: [
                    if (!(PlatformEnumFlutter.isWebDesktop ||
                            state.isListLoadedFull) ||
                        state.unmodifiedIsEmpty)
                      if (state.isFilterListEmpty)
                        SliverList.builder(
                          itemCount:
                              //  (state.filterDiscountModelList.isEmpty
                              //         ?
                              config.loadingItems
                                  // : KDimensions.shimmerDiscountsItems)
                                  *
                                  2,
                          // prototypeItem: SkeletonizerWidget(
                          //   isLoading: false,
                          //   child: DiscountCardWidget(
                          //     key: DiscountsKeys.card,
                          //     discountItem: KMockText.discountModel,
                          //     isDesk: isDesk,
                          //     share: '',
                          //   ),
                          // ),
                          itemBuilder: (context, index) {
                            if (index.isEven) {
                              return SkeletonizerWidget(
                                key: const ValueKey('discount_mock_card'),
                                isLoading: true,
                                child: DiscountCardWidget(
                                  key: DiscountsKeys.card,
                                  discountItem: KMockText.discountModel,
                                  isDesk: isDesk,
                                  share: '',
                                ),
                              );
                            } else {
                              return KSizedBox.kHeightSizedBox48;
                            }
                          },
                        )
                      else ...[
                        KSizedBox.kHeightSizedBox48.toSliver,
                        SkeletonizerWidget(
                          isLoading: true,
                          isSliver: true,
                          child: SliverToBoxAdapter(
                            child: DiscountCardWidget(
                              key: DiscountsKeys.card,
                              discountItem: KMockText.discountModel,
                              isDesk: isDesk,
                              share: '',
                            ),
                          ),
                        ),
                      ]
                    else if (state.isListLoadedFull)
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(
                          vertical: KPadding.kPaddingSize48,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: Center(
                            child: Text(
                              context.l10n.thatEndOfList,
                              key: DiscountsKeys.endListText,
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
                            widgetKey: ScaffoldKeys.loadingButton,
                            text: context.l10n.moreDiscounts,
                            onPressed: () => context
                                .read<DiscountsWatcherBloc>()
                                .add(
                                  const DiscountsWatcherEvent.loadNextItems(),
                                ),
                            isDesk: isDesk,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class DiscountsSliverList extends StatelessWidget {
  const DiscountsSliverList({
    required this.isDesk,
    required this.filterDiscountModelList,
    required this.config,
    super.key,
  });

  final bool isDesk;
  final List<DiscountModel> filterDiscountModelList;
  final DiscountConfigState config;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      findChildIndexCallback: (key) => _findChildIndexCallback(
        key: key,
        filterDiscountModelList: filterDiscountModelList,
        config: config,
      ),
      itemCount: (_itemCount(
                filterDiscountModelList: filterDiscountModelList,
                config: config,
              ) *
              2) -
          1,
      itemBuilder: (context, index) {
        if (index.isEven) {
          final indexValue = (index / 2).toInt();
          return _DiscountsWidgetItem(
            isDesk: isDesk,
            key: _key(
              filterDiscountModelList: filterDiscountModelList,
              index: indexValue,
              config: config,
            ),
            filterDiscountModelList: filterDiscountModelList,
            index: indexValue,
            config: config,
          );
        } else {
          return KSizedBox.kHeightSizedBox48;
        }
      },
    );
  }
}

class _DiscountsWidgetItem extends StatelessWidget {
  const _DiscountsWidgetItem({
    required this.index,
    required this.config,
    required this.isDesk,
    required this.filterDiscountModelList,
    super.key,
  });
  final bool isDesk;
  final List<DiscountModel> filterDiscountModelList;
  final int index;
  final DiscountConfigState config;
  @override
  Widget build(BuildContext context) {
    var indexValue = index;

    if (config.linkInt <= index &&
        filterDiscountModelList.length > config.linkInt) {
      indexValue--;
    }
    if (config.linkInt == index + 1) {
      return DiscountLinkWidget(
        isDesk: isDesk,
      );
    }
    final discountItem = filterDiscountModelList.elementAt(indexValue);
    return DiscountCardWidget(
      key: DiscountsKeys.card,
      discountItem: discountItem,
      isDesk: isDesk,
      share: '${KRoute.home.path}${KRoute.discounts.path}/${discountItem.id}',
    );
  }
}

class DiscountsDeskWidgetList extends StatelessWidget {
  const DiscountsDeskWidgetList({required this.maxHeight, super.key});
  final double maxHeight;
  @override
  Widget build(BuildContext context) {
    return SliverCrossAxisGroup(
      slivers: [
        SliverCrossAxisExpanded(
          flex: 1,
          sliver: _AdvancedFilterDesk(
            maxHeight: maxHeight,
          ),
        ),
        if (Config.isWeb)
          const SliverCrossAxisExpanded(
            flex: 2,
            sliver: _DiscountWidgetList(
              isDesk: true,
            ),
          )
        else
          const _DiscountWidgetList(
            isDesk: true,
          ),
      ],
    );
  }
}

// class _DiscountGridWidgetList extends StatelessWidget {
//   const _DiscountGridWidgetList({required this.isDesk});
//   final bool isDesk;

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<DiscountConfigCubit, DiscountConfigState>(
//       builder: (context, config) {
//         return BlocSelector<
//             DiscountsWatcherBloc,
//             DiscountsWatcherState,
//             ({
//               // LoadingStatus loadingStatus,
//               List<DiscountModel> filterDiscountModelList,
//               bool isListLoadedFull,
//             })>(
//           // buildWhen: (previous, current) =>
//           //     previous.loadingStatus != current.loadingStatus ||
//           //     previous.filterDiscountModelList !=
//           //         current.filterDiscountModelList,
//           selector: (state) => (
//             // loadingStatus: state.loadingStatus,
//             filterDiscountModelList: state.filterDiscountModelList,
//             isListLoadedFull: state.isListLoadedFull,
//           ),
//           builder: (context, state) {
//             final hasItems = state.filterDiscountModelList.isNotEmpty;
//             return SliverMainAxisGroup(
//               slivers: [
//                 if (hasItems)
//                   SliverPadding(
//                     padding: const EdgeInsets.all(KPadding.kPaddingSize24),
//                     sliver: SliverMasonryGrid(
//                       crossAxisSpacing: KPadding.kPaddingSize24,
//                       mainAxisSpacing: KPadding.kPaddingSize24,
//                       gridDelegate:
//                           const
// SliverSimpleGridDelegateWithMaxCrossAxisExtent(
//                         maxCrossAxisExtent: KSize.kPixel500,
//                       ),
//                       delegate: SliverChildBuilderDelegate(
//                         (context, index) {
//                           return DiscountCardWidget(
//                             discountItem:
//                                 state.filterDiscountModelList.elementAt
// (index),
//                             isDesk: false,
//                             share:
//                                 '${KRoute.home.path}${KRoute.discounts.path}/${state.filterDiscountModelList.elementAt(index).id}',
//                             dialogIsDesk: true,
//                           );
//                         },
//                         childCount: state.filterDiscountModelList.length,
//                         findChildIndexCallback: (key) =>
//                             _findChildIndexCallback(
//                           key: key,
//                           filterDiscountModelList:
//                               state.filterDiscountModelList,
//                           config: config,
//                         ),
//                       ),
//                     ),
//                   )
//                 else
//                   SliverList.builder(
//                     itemCount: config.loadingItems * 2,
//                     itemBuilder: (context, index) {
//                       if (index.isEven) {
//                         return SkeletonizerWidget(
//                           key: const ValueKey('discount_mock_card'),
//                           isLoading: true,
//                           child: DiscountCardWidget(
//                             key: DiscountsKeys.card,
//                             discountItem: KMockText.discountModel,
//                             isDesk: isDesk,
//                             share: '',
//                           ),
//                         );
//                       } else {
//                         return KSizedBox.kHeightSizedBox48;
//                       }
//                     },
//                   ),
//                 if (hasItems && state.isListLoadedFull)
//                   SliverPadding(
//                     padding: const EdgeInsets.symmetric(
//                       vertical: KPadding.kPaddingSize48,
//                     ),
//                     sliver: SliverToBoxAdapter(
//                       child: Center(
//                         child: Text(
//                           context.l10n.thatEndOfList,
//                           key: InvestorsKeys.endListText,
//                           style: AppTextStyle
//                               .materialThemeTitleMediumNeutralVariant70,
//                         ),
//                       ),
//                     ),
//                   )
//                 else if (hasItems && !state.isListLoadedFull)
//                   SliverPadding(
//                     padding: const EdgeInsets.symmetric(
//                       vertical: KPadding.kPaddingSize48,
//                     ),
//                     sliver: SliverToBoxAdapter(
//                       child: LoadingButtonWidget(
//                         widgetKey: ScaffoldKeys.loadingButton,
//                         text: context.l10n.moreDiscounts,
//                         onPressed: () =>
//                             context.read<DiscountsWatcherBloc>().add(
//                                   const DiscountsWatcherEvent.
// loadNextItems(),
//                                 ),
//                         isDesk: isDesk,
//                       ),
//                     ),
//                   ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
// }
