import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:kozak/shared/shared.dart';

class FilterCubitBlocprovider extends StatelessWidget {
  const FilterCubitBlocprovider({required this.childWidget, super.key});

  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetIt.I.get<FilterCubit>()),
      ],
      child: childWidget,
    );
  }
}
