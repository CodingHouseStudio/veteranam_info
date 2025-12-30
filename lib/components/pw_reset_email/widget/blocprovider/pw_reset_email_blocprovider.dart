import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:veteranam/components/pw_reset_email/bloc/pw_reset_email_bloc.dart';

class PwResetEmailBlocprovider extends StatelessWidget {
  const PwResetEmailBlocprovider({
    required this.childWidget,
    required this.email,
    super.key,
  });

  final Widget childWidget;
  final String? email;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<PwResetEmailBloc>()
        ..add(PwResetEmailEvent.started(email)),
      child: childWidget,
    );
  }
}
