import 'package:flutter/material.dart';
import 'package:veteranam/components/work/work.dart';
import 'package:veteranam/shared/shared.dart';

class WorkScreen extends StatelessWidget {
  const WorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WorkBodyWidget(key: KWidgetkeys.screen.work.screen);
  }
}
