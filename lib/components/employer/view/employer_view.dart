import 'package:flutter/material.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/components/employer/widget/body/employer_body_widget.dart';
import 'package:kozak/shared/shared.dart';

class EmployerScreen extends StatelessWidget {
  const EmployerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EmployerBodyWidget(key: KWidgetkeys.screen.employer.screen);
  }
}
