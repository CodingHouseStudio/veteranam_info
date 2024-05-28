import 'package:flutter/material.dart';
import 'package:kozak/components/employee_respond/widget/blocprovider/employee_respond_blocprovider.dart';
import 'package:kozak/components/employee_respond/widget/body/employee_respond_body.dart';
import 'package:kozak/shared/constants/constants.dart';

class EmployeeRespondScreen extends StatelessWidget {
  const EmployeeRespondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EmployeeRespondBlocprovider(
      key: KWidgetkeys.screen.employeeRespond.screen,
      childWidget: const EmployeeRespondBodyWidget(),
    );
  }
}
