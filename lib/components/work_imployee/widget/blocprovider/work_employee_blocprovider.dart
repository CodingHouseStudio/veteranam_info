import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkEmployeeBlocprovider extends StatelessWidget {
  const WorkEmployeeBlocprovider({Key? key}) : super(key: key);
  final Widget childWidget;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {},
      child: childWidget,
    );
  }
}
