import 'package:flutter/material.dart';
import 'package:veteranam/components/sign_up/sign_up.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SignUpBlocprovider(
      key: SignUpKeys.screen,
      childWidget: const SignUpBodyWidget(),
    );
  }
}
