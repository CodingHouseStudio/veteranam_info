import 'package:flutter/material.dart';
import 'package:veteranam/components/home/home.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeBlocprovider(
      key: HomeKeys.screen,
      childWidget: Scaffold(
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
  }
}
