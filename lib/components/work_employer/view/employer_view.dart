import 'package:flutter/material.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

class WorkEmployerScreen extends StatelessWidget {
  const WorkEmployerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WorkEmployerBodyWidget(key: KWidgetkeys.screen.employer.screen);
  }
}
