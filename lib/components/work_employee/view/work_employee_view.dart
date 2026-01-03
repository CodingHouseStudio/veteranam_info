import 'package:flutter/widgets.dart';
import 'package:veteranam/components/work_employee/work_employee.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class WorkEmployeeScreen extends StatelessWidget {
  const WorkEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const WorkEmployeeBlocprovider(
      key: WorkEmployeeKeys.screen,
      childWidget: WorkEmployeeBody(),
    );
  }
}
