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
          previous.loadingStatus != current.loadingStatus ||
          previous.filterLocation != current.filterLocation ||
          previous.choosenLocationList != current.choosenLocationList ||
          previous.choosenCategoriesnList != current.choosenCategoriesnList ||
          current.filterCategory != previous.filterCategory ||
          previous.choosenCategoriesnList != current.choosenEligibilitiesList ||
          current.filterCategory != previous.filterEligibilities,
      builder: (context, state) {
        return AdvancedFilterContent(
          key: KWidgetkeys.screen.discounts.advancedFilterDesk,
          isDesk: true,
          onLocationChange: (value) => context
              .read<DiscountWatcherBloc>()
              .add(DiscountWatcherEvent.filterLocation(value)),
          filterLocationes: state.filterLocation,
          chooseLocationList: state.choosenLocationList,
          filterCategories: state.filterCategory,
          chooseCategoriesList: state.choosenCategoriesnList,
          onCategoriesChange: (value) => context
              .read<DiscountWatcherBloc>()
              .add(DiscountWatcherEvent.filterCategory(value)),
          filterEligibilities: state.filterEligibilities,
          chooseEligibilitiesList: state.choosenEligibilitiesList,
          onEligibilitiesChange: (value) => context
              .read<DiscountWatcherBloc>()
              .add(DiscountWatcherEvent.filterEligibilities(value)),
        );
      },
    );
  }
}
