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
      // TODO(refactor): add build when
      builder: (context, state) {
        if (isDesk) {
          return Expanded(
            child: _Filter(
              isDesk: isDesk,
              state: state,
            ),
          );
        } else {
          return Column(
            children: [
              _Filter(
                isDesk: isDesk,
                state: state,
              ),
              KSizedBox.kHeightSizedBox24,
              AdvancedFilterMob(
                key: KWidgetkeys.screen.discounts.advancedFilterMob,
              ),
            ],
          );
        }
      },
    );
  }
}

class _Filter extends StatelessWidget {
  const _Filter({required this.isDesk, super.key, required this.state});
  final bool isDesk;
  final DiscountWatcherState state;

  @override
  Widget build(BuildContext context) {
    return FiltersChipWidget(
      key: KWidgetkeys.screen.discounts.filter,
      filtersItems: state.filterCategory,
      isDesk: isDesk,
      // onResetValue: () => context.read<DiscountWatcherBloc>().add(
      //       const DiscountWatcherEvent.filterReset(),
      //     ),
      isSelected: null,
      // isSelected: (index) => state.filterCategory.elementAt(index),
      onSelected: (value) => context.read<DiscountWatcherBloc>().add(
            DiscountWatcherEvent.filterCategory(
              value,
            ),
          ),
      fullLength: state.locationDiscountModelItems.length,
      filterIsEmpty: state.categoryListEmpty,
    );
  }
}
