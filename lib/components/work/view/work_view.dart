import 'package:flutter/material.dart';
import 'package:veteranam/components/work/work.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class WorkScreen extends StatelessWidget {
  const WorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const WorkBodyWidget(key: WorkKeys.screen);
  }
}
