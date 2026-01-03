import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

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
