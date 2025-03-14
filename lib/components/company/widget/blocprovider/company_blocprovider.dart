import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/company/bloc/company_form_bloc.dart';

class CompanyBlocprovider extends StatelessWidget {
  const CompanyBlocprovider({required this.childWidget, super.key});
  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<CompanyFormBloc>(),
      child: childWidget,
    );
  }
}
