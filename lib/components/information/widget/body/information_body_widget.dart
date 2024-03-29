import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class InformationBodyWidget extends StatelessWidget {
  const InformationBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        FooterDescWidget(),
      ],
    );
  }
}
