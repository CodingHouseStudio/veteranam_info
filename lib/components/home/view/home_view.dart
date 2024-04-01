import 'package:flutter/material.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeBlocprovider(
      key: KWidgetkeys.homeKeys.screen,
      childWidget: const HomeBodyWidget(),
    );
  }
}
