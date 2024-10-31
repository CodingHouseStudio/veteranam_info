import 'package:flutter/material.dart';
import 'package:veteranam/components/information/information.dart';
import 'package:veteranam/shared/shared_flutter.dart';

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
