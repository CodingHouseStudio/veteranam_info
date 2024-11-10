import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
          return Row(
            children: [
              Expanded(
                child: _filter(
                  context: context,
                  isDesk: isDesk,
                ),
              ),
              if (Config.isBusiness) _myDiscountButton(context),
            ],
          );
        } else {
          return Column(
            children: [
              _filter(
                context: context,
                isDesk: isDesk,
              ),
              if (Config.isBusiness) ...[
                KSizedBox.kHeightSizedBox8,
                _myDiscountButton(context),
              ],
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

  Widget _filter({
    required BuildContext context,
    required bool isDesk,
  }) =>
      FiltersChipWidget(
        key: KWidgetkeys.screen.discounts.filter,
        filtersItems: context
            .read<DiscountWatcherBloc>()
            .state
            .discountModelItems
            .overallItems(
              context: context,
              getENFilter: (item) => item.categoryEN,
              getUAFilter: (item) => item.category,
              numberGetList: context
                  .read<DiscountWatcherBloc>()
                  .state
                  .locationDiscountModelItems,
            ),
        isDesk: isDesk,
        // onResetValue: () => context.read<DiscountWatcherBloc>().add(
        //       const DiscountWatcherEvent.filterReset(),
        //     ),
        isSelected: (index) => context
            .read<DiscountWatcherBloc>()
            .state
            .filtersCategories
            .contains(index),
        onSelected: (index) => context.read<DiscountWatcherBloc>().add(
              DiscountWatcherEvent.filterCategory(
                index,
              ),
            ),
        fullLength: context
            .read<DiscountWatcherBloc>()
            .state
            .locationDiscountModelItems
            .length,
        filterIsEmpty:
            context.read<DiscountWatcherBloc>().state.filtersCategories.isEmpty,
      );

  Widget _myDiscountButton(
    BuildContext context,
  ) =>
      TextButton(
        key: KWidgetkeys.screen.discounts.addDiscountButton,
        onPressed: () => context.goNamed(KRoute.myDiscounts.name),
        style: KButtonStyles.whiteButtonStyle,
        child: Text(context.l10n.offerDiscount),
      );
}
