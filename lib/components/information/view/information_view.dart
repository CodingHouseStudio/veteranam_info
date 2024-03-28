import 'package:flutter/material.dart';
import 'package:kozak/components/information/information.dart';
import 'package:kozak/shared/shared.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: KWidgetkeys.informationKeys.screen,
      appBar: AppBar(
        title: const Text('Information Page'),
      ),
      body: const InformationBodyWidget(),
    );
  }
}
