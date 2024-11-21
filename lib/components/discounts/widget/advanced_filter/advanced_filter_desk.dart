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
          previous.sorting != current.sorting ||
          previous.choosenLocationList != current.choosenLocationList ||
          current.choosenSortingnList != previous.choosenSortingnList,
      builder: (context, state) {
        return AdvancedFilterContent(
          key: KWidgetkeys.screen.discounts.advancedFilterDesk,
          isDesk: true,
          onChange: (value) => context
              .read<DiscountWatcherBloc>()
              .add(DiscountWatcherEvent.filterLocation(value)),
          filterLocationes: state.filterLocation,
          sorting: state.sorting,
          onChangeSorting: (value) => context
              .read<DiscountWatcherBloc>()
              .add(DiscountWatcherEvent.sorting(value)),
          chooseLocationList: state.choosenLocationList,
          chooseSortingList: state.choosenSortingnList,
        );
      },
    );
  }
}
