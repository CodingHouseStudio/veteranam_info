import 'package:flutter/material.dart';
import 'package:veteranam/components/home/home.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffold = HomeBlocprovider(
      childWidget: Scaffold(
        key: KWidgetkeys.screen.home.screen,
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: Config.isWeb
            ? null
            : const MobNavigationWidget(
                index: 0,
              ),
        appBar: appBar,
        body: const HomeBodyWidget(),
      ),
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
