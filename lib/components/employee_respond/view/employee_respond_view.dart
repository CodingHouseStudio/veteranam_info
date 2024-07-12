import 'package:flutter/material.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

class EmployeeRespondScreen extends StatelessWidget {
  const EmployeeRespondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EmployeeRespondBlocprovider(
      childWidget: const EmployeeRespondBodyWidget(),
      key: KWidgetkeys.screen.employeeRespond.screen,
    );
  }
}
