import 'package:flutter/widgets.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class WorkEmployeeScreen extends StatelessWidget {
  const WorkEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WorkEmployeeBlocprovider(
      key: KWidgetkeys.screen.workEmployee.screen,
      childWidget: const WorkEmployeeBody(),
    );
  }
}
