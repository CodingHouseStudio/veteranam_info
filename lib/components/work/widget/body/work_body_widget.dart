import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class WorkBodyWidget extends StatelessWidget {
  const WorkBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        FooterDescWidget(),
      ],
    );
  }
}
