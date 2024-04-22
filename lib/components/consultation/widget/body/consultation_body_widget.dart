import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class ConsultationBodyWidget extends StatelessWidget {
  const ConsultationBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      childWidgetsFunction: ({required isDesk}) => [
        KSizedBox.kHeightSizedBox30,
      ],
    );
  }
}
