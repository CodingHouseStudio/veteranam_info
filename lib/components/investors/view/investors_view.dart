import 'package:flutter/material.dart';
import 'package:veteranam/components/investors/investors.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class InvestorsScreen extends StatelessWidget {
  const InvestorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Config.isWeb
          ? null
          : const MobNavigationWidget(
              index: 0,
            ),
      appBar: AppBar(
        backgroundColor: AppColors.materialThemeWhite,
        toolbarHeight: KSize.kAppBarHeight,
      ),
      body: InvestorsBodyWidget(key: KWidgetkeys.screen.investors.screen),
    );
  }
}
