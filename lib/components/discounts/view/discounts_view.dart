import 'package:flutter/material.dart';
import 'package:kozak/components/discounts/discounts.dart';
import 'package:kozak/shared/shared.dart';

class DiscountsScreen extends StatelessWidget {
  const DiscountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: KWIdgetkeys.discountsKeys.screen,
      appBar: AppBar(
        title: const Text('Discounts Page'),
      ),
      body: const DiscountsBodyWidget(),
    );
  }
}
