import 'package:flutter/material.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class WorkEmployerScreen extends StatelessWidget {
  const WorkEmployerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WorkEmployerBodyWidget(key: KWidgetkeys.screen.employer.screen);
  }
}
