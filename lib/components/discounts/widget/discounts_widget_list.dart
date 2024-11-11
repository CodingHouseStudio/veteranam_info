import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/components/discounts/discounts.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountsWidgetList extends StatelessWidget {
  const DiscountsWidgetList({required this.isDesk, super.key});
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    if (isDesk) {
      //TODO: FIX
      return const Row(
        children: [
          Expanded(child: AdvancedFilterDesk()),
          _DiscountsWidgetList(isDesk: true),
        ],
      );
    } else {
      return const _DiscountsWidgetList(isDesk: false);
    }
  }
}

class _DiscountsWidgetList extends StatelessWidget {
  const _DiscountsWidgetList({required this.isDesk});
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscountWatcherBloc, DiscountWatcherState>(
      buildWhen: (previous, current) =>
          previous.loadingStatus != current.loadingStatus ||
          previous.filteredDiscountModelItems !=
              current.filteredDiscountModelItems,
      builder: (context, state) {
        switch (state.loadingStatus) {
          case LoadingStatus.loaded:
          case LoadingStatus.listLoadedFull:
            return ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: state.filteredDiscountModelItems.length,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              // addAutomaticKeepAlives: false,
              // addRepaintBoundaries: false,
              itemBuilder: (context, index) {
                final discountItem =
                    state.filteredDiscountModelItems.elementAt(index);
                if ((context.read<DiscountConfigCubit>().state.linkScrollCount +
                            1) *
                        context
                            .read<DiscountConfigCubit>()
                            .state
                            .loadingItems ==
                    index + 1) {
                  return ListView(
                    primary: false,
                    shrinkWrap: true,
                    children: [
                      DiscountCardWidget(
                        key: ValueKey(discountItem.id),
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
                  return DiscountCardWidget(
                    key: ValueKey(discountItem.id),
                    discountItem: discountItem,
                    isDesk: isDesk,
                    // reportEvent: null,
                    share:
                        '${KRoute.home.path}${KRoute.discounts.path}/${discountItem.id}',
                    isLoading: false,
                    // () => context
                    //     .read<DiscountWatcherBloc>()
                    //     .add(const DiscountWatcherEvent.getReport()),
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
          case LoadingStatus.initial:
          case LoadingStatus.error:
          case LoadingStatus.loading:
            // TODO(refactor): change
            return const SizedBox.shrink();
        }
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
