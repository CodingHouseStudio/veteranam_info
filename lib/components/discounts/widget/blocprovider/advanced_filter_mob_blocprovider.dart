import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/components.dart';

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
          bloc.state.filtersLocation,
        ),
      child: childWidget,
    );
  }
}
