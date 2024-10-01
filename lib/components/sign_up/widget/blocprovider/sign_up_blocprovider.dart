import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/sign_up/sign_up.dart';
import 'package:veteranam/shared/shared.dart';

class SignUpBlocprovider extends StatelessWidget {
  const SignUpBlocprovider({required this.childWidget, super.key});
  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetIt.I.get<SignUpBloc>()),
        BlocProvider(
          create: (context) => GetIt.I.get<AuthenticationServicesCubit>(),
        ),
      ],
      child: childWidget,
    );
  }
}
