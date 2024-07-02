import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/components.dart';

class MyDiscountsBlocprovider extends StatelessWidget {
  const MyDiscountsBlocprovider({required this.childWidget, super.key});
  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<MyDiscountsWatcherBloc>()
        ..add(
          const MyDiscountsWatcherEvent.started(),
        ),
      child: childWidget,
    );
  }
}
