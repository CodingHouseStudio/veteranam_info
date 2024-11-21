import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/shared/constants/models.dart';

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
  final List<FilterItem<String>> initialFilter;
  final List<FilterItem<String>> initialCategories;
  final List<FilterItem<String>> initialEligibilities;
  final List<FilterItem<String>> initChooseLocationList;
  final List<FilterItem<String>> initialChooseCategories;
  final List<FilterItem<String>> initialChooseEligibilities;

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
