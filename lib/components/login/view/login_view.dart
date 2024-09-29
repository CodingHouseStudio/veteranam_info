import 'package:flutter/material.dart';
import 'package:veteranam/components/login/login.dart';
import 'package:veteranam/shared/shared.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginBlocprovider(
      key: KWidgetkeys.screen.login.screen,
      childWidget: const LoginBodyWidget(),
    );
  }
}
