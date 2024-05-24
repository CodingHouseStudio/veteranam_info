import 'package:flutter/material.dart';
import 'package:kozak/components/employee_respond/widget/body/employee_respond_body.dart';
import 'package:kozak/shared/constants/constants.dart';

class EmployeeRespondScreen extends StatelessWidget {
  const EmployeeRespondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EmployeeRespondBodyWidget(
      key: KWidgetkeys.screen.employeeRespond.screen,
    );
  }
}
