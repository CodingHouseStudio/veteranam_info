import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/components/discounts/discounts.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class AdvancedFilterDesk extends StatelessWidget {
  const AdvancedFilterDesk({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscountWatcherBloc, DiscountWatcherState>(
      buildWhen: (previous, current) =>
          previous.discountFilterItems != current.discountFilterItems ||
          previous.discountFilterItems.getChoosenList !=
              current.discountFilterItems.getChoosenList,
      builder: (context, state) {
        return AdvancedFilterContent(
          key: KWidgetkeys.screen.discounts.advancedFilterDesk,
          isDesk: true,
          onLocationChange: (value) => context
              .read<DiscountWatcherBloc>()
              .add(DiscountWatcherEvent.filterLocation(value)),
          discountFilter: state.discountFilterItems,
          onCategoriesChange: (value) =>
              context.read<DiscountWatcherBloc>().add(
                    DiscountWatcherEvent.filterCategory(value),
                  ),
          onEligibilitiesChange: (value) => context
              .read<DiscountWatcherBloc>()
              .add(DiscountWatcherEvent.filterEligibilities(value)),
        );
      },
    );
  }
}
