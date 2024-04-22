import 'package:flutter/material.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
          body: SignUpBlocprovider(
            key: KWidgetkeys.screen.signUp.screen,
            childWidget: SignUpBodyWidget(
              isDesk: isDesk,
            ),
          ),
          backgroundColor: AppColors.blackWhite,
        );
      },
    );
  }
}
