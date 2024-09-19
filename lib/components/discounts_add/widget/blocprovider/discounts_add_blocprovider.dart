import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/components.dart';

class DiscountsAddBlocprovider extends StatelessWidget {
  const DiscountsAddBlocprovider({required this.childWidget, super.key});
  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<DiscountsAddBloc>()
        ..add(const DiscountsAddEvent.started()),
      child: childWidget,
    );
  }
}
