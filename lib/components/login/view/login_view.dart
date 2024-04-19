import 'package:flutter/material.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesk =
            constraints.maxWidth > KPlatformConstants.minWidthThresholdTablet;
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: NawbarWidget(
            isDesk: isDesk,
          ),
          body: LoginBlocprovider(
            key: KWidgetkeys.screen.login.screen,
            childWidget: LoginBodyWidget(
              isDesk: isDesk,
            ),
          ),
          backgroundColor: AppColors.blackWhite,
        );
      },
    );
  }
}
