import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/password_reset/bloc/bloc.dart';

class PasswordResetBlocprovider extends StatelessWidget {
  const PasswordResetBlocprovider({
    required this.childWidget,
    super.key,
    this.code,
  });

  final Widget childWidget;
  final String? code;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetIt.I.get<PasswordResetBloc>(),
        ),
        BlocProvider(
          create: (context) =>
              GetIt.I.get<CheckVerificationCodeCubit>(param1: code),
        ),
      ],
      child: childWidget,
    );
  }
}
