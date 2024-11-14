import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/components/discounts/discounts.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountsFilterWidget extends StatelessWidget {
  const DiscountsFilterWidget({required this.isDesk, super.key});
  final bool isDesk;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscountWatcherBloc, DiscountWatcherState>(
      buildWhen: (previous, current) =>
          // previous.loadingStatus != current.loadingStatus ||
          previous.filterCategory != current.filterCategory ||
          // previous.locationDiscountModelItems !=
          //     current.locationDiscountModelItems ||
          previous.categoryListEmpty != current.categoryListEmpty,
      builder: (context, state) {
        // if (state.loadingStatus == LoadingStatus.loading) {
        //   return const Center(
        //     child: CircularProgressIndicator(),
        //   );
        // } else {
        final filterWidget = FilterChipBodyWidget(
          isDesk: isDesk,
          filtersItems: state.filterCategory,
          fullLength: state.locationDiscountModelItems.length,
          filterIsEmpty: state.categoryListEmpty,
          onSelected: (value) => context.read<DiscountWatcherBloc>().add(
                DiscountWatcherEvent.filterCategory(
                  value,
                ),
              ),
        );

        final childWidget = isDesk
            ? filterWidget
            : Column(
                children: [
                  filterWidget,
                  KSizedBox.kHeightSizedBox24,
                  AdvancedFilterMob(
                    key: KWidgetkeys.screen.discounts.advancedFilterMob,
                  ),
                ],
              );

        return ShaderWidget(
          isDesk: isDesk,
          child: childWidget,
        );
        // }
      },
    );
  }
}
