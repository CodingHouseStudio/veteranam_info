import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/pw_reset_email/pw_reset_email.dart';

class PwResetEmailBlocprovider extends StatelessWidget {
  const PwResetEmailBlocprovider({required this.childWidget, super.key});

  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<PwResetEmailBloc>(),
      child: childWidget,
    );
  }
}
