import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/employee_respond/bloc/employee_respond_bloc.dart';

class EmployeeRespondBlocprovider extends StatelessWidget {
  const EmployeeRespondBlocprovider({
    required this.childWidget,
    super.key,
  });
  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<EmployeeRespondBloc>(),
      child: childWidget,
    );
  }
}
