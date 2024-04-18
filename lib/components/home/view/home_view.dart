import 'package:flutter/material.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NawbarWidget(
        isDesk: false,
        hasMicrophone: false,
      ),
      body: HomeBlocprovider(
        key: KWidgetkeys.screen.home.screen,
        childWidget: const HomeBodyWidget(),
      ),
    );
  }
}
