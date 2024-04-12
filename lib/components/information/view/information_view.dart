import 'package:flutter/material.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InformationBlocprovider(
      childWidget: InformationBodyWidget(
        key: KWidgetkeys.screen.information.screen,
      ),
    );
  }
}
