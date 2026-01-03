import 'package:flutter/material.dart';
import 'package:veteranam/components/investors/investors.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class InvestorsScreen extends StatelessWidget {
  const InvestorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Config.isWeb
          ? null
          : const MobNavigationWidget(
              index: 1,
            ),
      appBar: appBar,
      body: const InvestorsBodyWidget(key: InvestorsKeys.screen),
    );
    if (Config.isWeb) {
      return scaffold;
    }
    return ColoredBox(
      color: AppColors.materialThemeWhite,
      child: SafeArea(child: scaffold),
    );
  }
}
