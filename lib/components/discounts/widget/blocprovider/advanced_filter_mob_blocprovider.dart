import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/shared/constants/models.dart';

class AdvancedFilterMobBlocprovider extends StatelessWidget {
  const AdvancedFilterMobBlocprovider({
    required this.childWidget,
    required this.initialFilter,
    required this.initialSorting,
    required this.initChooseLocationList,
    required this.initialChooseSorting,
    super.key,
  });

  final Widget childWidget;
  final List<FilterItem> initialFilter;
  final List<SortingItem> initialSorting;
  final List<FilterItem> initChooseLocationList;
  final List<SortingItem> initialChooseSorting;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<AdvancedFilterMobCubit>()
        ..started(
          initialLocationFilter: initialFilter,
          initialSorting: initialSorting,
          initChooseLocationList: initChooseLocationList,
          initialChooseSorting: initialChooseSorting,
        ),
      child: childWidget,
    );
  }
}
