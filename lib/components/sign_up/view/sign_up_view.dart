import 'package:flutter/material.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SignUpBlocprovider(
      key: KWidgetkeys.screen.signUp.screen,
      childWidget: const SignUpBodyWidget(),
    );
  }
}
