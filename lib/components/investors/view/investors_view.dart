import 'package:flutter/material.dart';
import 'package:veteranam/components/investors/investors.dart';
import 'package:veteranam/shared/shared.dart';

class InvestorsScreen extends StatelessWidget {
  const InvestorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InvestorsBodyWidget(key: KWidgetkeys.screen.investors.screen);
  }
}
