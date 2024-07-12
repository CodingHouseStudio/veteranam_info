import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class ConsultationBodyWidget extends StatelessWidget {
  const ConsultationBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      mainChildWidgetsFunction: ({required isDesk, required isTablet}) => [
        KSizedBox.kHeightSizedBox30,
      ],
    );
  }
}
