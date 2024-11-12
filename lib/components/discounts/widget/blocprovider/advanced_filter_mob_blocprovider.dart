import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';

class AdvancedFilterMobBlocprovider extends StatelessWidget {
  const AdvancedFilterMobBlocprovider({
    required this.childWidget,
    required this.bloc,
    super.key,
  });

  final Widget childWidget;
  final DiscountWatcherBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<AdvancedFilterMobCubit>()
        ..started(
          initialFilter: bloc.state.filterLocation,
          initialSorting: bloc.state.sorting,
          initChoosenLocationList: bloc.state.choosenLocationList,
        ),
      child: childWidget,
    );
  }
}
