import 'package:flutter/material.dart';
import 'package:veteranam/components/consultation/consultation.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class ConsultationScreen extends StatelessWidget {
  const ConsultationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ConsultationBodyWidget(
      key: ConsultationKeys.screen,
    );
  }
}
