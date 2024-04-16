import 'package:flutter/material.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

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
