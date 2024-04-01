import 'package:flutter/material.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class InvestorsScreen extends StatelessWidget {
  const InvestorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InvestorsBodyWidget(key: KWidgetkeys.investorsKeys.screen);
  }
}
