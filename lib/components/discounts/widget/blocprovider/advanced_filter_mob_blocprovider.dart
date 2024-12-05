import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/shared/models/filter_model.dart';

class AdvancedFilterMobBlocprovider extends StatelessWidget {
  const AdvancedFilterMobBlocprovider({
    required this.childWidget,
    required this.initialFilter,
    required this.initChooseLocationList,
    required this.initialCategories,
    required this.initialChooseCategories,
    required this.initialEligibilities,
    required this.initialChooseEligibilities,
    super.key,
  });

  final Widget childWidget;
  final List<FilterItem> initialFilter;
  final List<FilterItem> initialCategories;
  final List<FilterItem> initialEligibilities;
  final List<FilterItem> initChooseLocationList;
  final List<FilterItem> initialChooseCategories;
  final List<FilterItem> initialChooseEligibilities;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<AdvancedFilterMobCubit>()
        ..started(
          initialLocationFilter: initialFilter,
          initChooseLocationList: initChooseLocationList,
          initialCategories: initialCategories,
          initialChooseCategories: initialChooseCategories,
          initialEligibilities: initialEligibilities,
          initialChooseEligibilities: initialChooseEligibilities,
        ),
      child: childWidget,
    );
  }
}
