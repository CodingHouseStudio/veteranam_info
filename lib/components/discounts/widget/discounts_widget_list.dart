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
    return BlocBuilder<DiscountWatcherBloc, DiscountWatcherState>(
      builder: (context, state) {
        switch (state.loadingStatus) {
          case LoadingStatus.loaded:
          case LoadingStatus.listLoadedFull:
            return ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: state.discountModelItems.length,
              itemBuilder: (context, index) {
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
                        key: ValueKey(
                            state.discountModelItems.elementAt(index).id),
                        discountItem: state.discountModelItems.elementAt(index),
                        isDesk: isDesk,
                        // reportEvent: null,
                        share:
                            '${KRoute.home.path}${KRoute.discounts.path}/${state.discountModelItems.elementAt(index).id}',
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
                    key: ValueKey(state.discountModelItems.elementAt(index).id),
                    discountItem: state.discountModelItems.elementAt(index),
                    isDesk: isDesk,
                    // reportEvent: null,
                    share:
                        '${KRoute.home.path}${KRoute.discounts.path}/${state.discountModelItems.elementAt(index).id}',
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

List<Widget> discountsWidgetList({
  required BuildContext context,
  required bool isDesk,
}) {
  final items = cardWidgetList<DiscountModel>(
    loadingStatus: context.read<DiscountWatcherBloc>().state.loadingStatus,
    modelItems:
        context.read<DiscountWatcherBloc>().state.filteredDiscountModelItems,
    cardWidget: ({required modelItem, required isLoading}) =>
        DiscountCardWidget(
      key: KWidgetkeys.screen.discounts.card,
      discountItem: modelItem,
      isDesk: isDesk,
      // reportEvent: null,
      share: '${KRoute.home.path}${KRoute.discounts.path}/${modelItem.id}',
      isLoading: isLoading,
      // () => context
      //     .read<DiscountWatcherBloc>()
      //     .add(const DiscountWatcherEvent.getReport()),
    ),
    isDesk: isDesk,
    shimmerItemsNumber: context.read<DiscountConfigCubit>().state.loadingItems,
    isNotFailure: context.read<DiscountWatcherBloc>().state.failure == null,
    shimmerItem: KMockText.discountModel,
  );

  final finalList = <Widget>[];
  for (var i = 0; i < items.length; i++) {
    finalList.add(items[i]);
    if ((context.read<DiscountConfigCubit>().state.linkScrollCount + 1) *
            context.read<DiscountConfigCubit>().state.loadingItems ==
        i + 1) {
      finalList.add(
        DiscountLinkWidget(isDesk: isDesk),
      );
    }
  }
  return finalList;
}
