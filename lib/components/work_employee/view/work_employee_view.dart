import 'package:flutter/widgets.dart';
import 'package:kozak/components/components.dart';

class WorkEmployeeScreen extends StatelessWidget {
  const WorkEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const WorkEmployeeBlocprovider(
      childWidget: WorkEmployeeBody(),
    );
  }
}
