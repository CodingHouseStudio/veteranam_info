import 'package:flutter/material.dart';

import 'package:veteranam/components/login/login.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginBlocprovider(
      key: LoginKeys.screen,
      childWidget: LoginBodyWidget(),
    );
  }
}
