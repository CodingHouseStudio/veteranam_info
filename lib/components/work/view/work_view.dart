import 'package:flutter/material.dart';
import 'package:kozak/components/work/work.dart';

class WorkScreen extends StatelessWidget {
  const WorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Work Page'),
      ),
      body: const WorkBodyWidget(),
    );
  }
}
