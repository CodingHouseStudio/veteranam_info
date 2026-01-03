import 'package:flutter/material.dart';
import 'package:veteranam/components/employee_respond/employee_respond.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class EmployeeRespondScreen extends StatelessWidget {
  const EmployeeRespondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmployeeRespondBlocprovider(
      childWidget: EmployeeRespondBodyWidget(),
      key: EmployeeRespondKeys.screen,
    );
  }
}
