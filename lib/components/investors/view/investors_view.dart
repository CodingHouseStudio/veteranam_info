import 'package:flutter/material.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

class InvestorsScreen extends StatelessWidget {
  const InvestorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InvestorsBlocprovider(
      key: KWidgetkeys.screen.investors.screen,
      childWidget: const InvestorsBodyWidget(),
    );
  }
}
