import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';

class InformationBlocprovider extends StatelessWidget {
  const InformationBlocprovider({required this.childWidget, super.key});
  final Widget childWidget;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<InformationWatcherBloc>()
        ..add(const InformationWatcherEvent.started()),
      child: childWidget,
    );
  }
}
