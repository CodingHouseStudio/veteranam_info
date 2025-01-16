import 'package:flutter/material.dart';
import 'package:veteranam/components/work_employer/employer.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class WorkEmployerScreen extends StatelessWidget {
  const WorkEmployerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const WorkEmployerBodyWidget(key: EmployerKeys.screen);
  }
}
