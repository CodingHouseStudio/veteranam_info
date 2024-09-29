import 'package:flutter/material.dart';
import 'package:veteranam/components/home/home.dart';
import 'package:veteranam/shared/shared.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeBlocprovider(
      key: KWidgetkeys.screen.home.screen,
      childWidget: const HomeBodyWidget(),
    );
  }
}
