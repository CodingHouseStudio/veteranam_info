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
                      itemCount: state.filteredDiscountModelItems.length +
                          (state.loadingStatus.isLoaded
                              ? 1
                              : config.loadingItems),
                      itemBuilder: (context, index) {
                        if (index < state.filteredDiscountModelItems.length) {
                          final discountItem =
                              state.filteredDiscountModelItems.elementAt(index);
                          if ((config.linkScrollCount + 1) *
                                  config.loadingItems ==
                              index + 1) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                top: KPadding.kPaddingSize48,
                              ),
                              child: ListView(
                                primary: false,
                                shrinkWrap: true,
                                children: [
                                  DiscountCardWidget(
                                    key: ValueKey(discountItem.id),
                                    discountItem: discountItem,
                                    isDesk: isDesk,
                                    share:
                                        '${KRoute.home.path}${KRoute.discounts.path}/${discountItem.id}',
                                    isLoading: false,
                                  ),
                                  DiscountLinkWidget(isDesk: isDesk),
                                ],
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.only(
                                top: KPadding.kPaddingSize48,
                              ),
                              child: DiscountCardWidget(
                                key: ValueKey(discountItem.id),
                                discountItem: discountItem,
                                isDesk: isDesk,
                                share:
                                    '${KRoute.home.path}${KRoute.discounts.path}/${discountItem.id}',
                                isLoading: false,
                              ),
                            );
                          }
                        } else {
                          if (state.loadingStatus.isLoaded) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                top: KPadding.kPaddingSize48,
                              ),
                              child: LoadingButtonWidget(
                                widgetKey: KWidgetkeys.screen.discounts.button,
                                text: context.l10n.moreDiscounts,
                                onPressed: () =>
                                    context.read<DiscountWatcherBloc>().add(
                                          const DiscountWatcherEvent
                                              .loadNextItems(),
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
                      },
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
    } else {
      return const _DiscountsMobWidgetList(isDesk: false);
    }
  }
}

class _DiscountsMobWidgetList extends StatelessWidget {
  const _DiscountsMobWidgetList({required this.isDesk});
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
            return ListView.builder(
              primary: false,
              addAutomaticKeepAlives: false,
              addRepaintBoundaries: false,
              shrinkWrap: true,
              restorationId: 'discount_list',
              findChildIndexCallback: (key) {
                final valueKey = key as ValueKey<String>;
                if (!valueKey.value.contains('mock_discount_')) {
                  return state.filteredDiscountModelItems.indexWhere(
                    (element) => element.id == valueKey.value,
                  );
                }
                final mockValue =
                    int.parse(valueKey.value.replaceAll('mock_discount_', ''));
                return state.filteredDiscountModelItems.length + mockValue;
              },
              itemCount: state.filteredDiscountModelItems.length +
                  (state.loadingStatus.isLoaded ? 3 : config.loadingItems),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemBuilder: (context, index) {
                if (index < state.filteredDiscountModelItems.length) {
                  final discountItem =
                      state.filteredDiscountModelItems.elementAt(index);
                  if ((config.linkScrollCount + 1) * config.loadingItems ==
                      index + 1) {
                    return ListView(
                      key: ValueKey(discountItem.id),
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
                      key: ValueKey(discountItem.id),
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
                  return Padding(
                    key: ValueKey(
                      'mock_discount'
                      '_${state.filteredDiscountModelItems.length - index}',
                    ),
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
                // cardWidgetList<DiscountModel>(
                //   loadingStatus:
                //       context.read<DiscountWatcherBloc>().state.
                // loadingStatus,
                //   modelItems: context
                //       .read<DiscountWatcherBloc>()
                //       .state
                //       .filteredDiscountModelItems,
                //   cardWidget: ({required modelItem, required isLoading}) =>
                //       DiscountCardWidget(
                //     key: KWidgetkeys.screen.discounts.card,
                //     discountItem: modelItem,
                //     isDesk: isDesk,
                //     // reportEvent: null,
                //     share:
                //         '${KRoute.home.path}${KRoute.discounts.path}/${modelItem.id}',
                //     isLoading: isLoading,
                //     // () => context
                //     //     .read<DiscountWatcherBloc>()
                //     //     .add(const DiscountWatcherEvent.getReport()),
                //   ),
                //   isDesk: isDesk,
                //   shimmerItemsNumber:
                //       context.read<DiscountConfigCubit>().state.loadingItems,
                //   isNotFailure:
                //       context.read<DiscountWatcherBloc>().
                //state.failure == null,
                //   shimmerItem: KMockText.discountModel,
                // );

                // final finalList = <Widget>[];
                // for (var i = 0; i < items.length; i++) {
                //   finalList.add(items[i]);
                //   if ((context
                //                   .read<DiscountConfigCubit>()
                //                   .state
                //                   .linkScrollCount +
                //               1) *
                //           context
                //               .read<DiscountConfigCubit>()
                //               .state
                //               .loadingItems ==
                //       i + 1) {
                //     finalList.add(
                //       DiscountLinkWidget(isDesk: isDesk),
                //     );
                //   }
                // }
                // return finalList;
              },
            );
          },
        );
      },
    );
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
//     shimmerItemsNumber: context.read<DiscountConfigCubit>().state.loadingItems,
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
