import 'package:flutter/material.dart';
import 'package:kozak/components/investors/investors.dart';

class InvestorsScreen extends StatelessWidget {
  const InvestorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Investors Page'),
      ),
      body: const InvestorsBodyWidget(),
    );
  }
}
