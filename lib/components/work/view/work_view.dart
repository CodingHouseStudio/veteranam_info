import 'package:flutter/material.dart';
import 'package:kozak/components/work/work.dart';
import 'package:kozak/shared/shared.dart';

class WorkScreen extends StatelessWidget {
  const WorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: KWIdgetkeys.workKeys.screen,
      appBar: AppBar(
        title: const Text('Work Page'),
      ),
      body: const WorkBodyWidget(),
    );
  }
}
