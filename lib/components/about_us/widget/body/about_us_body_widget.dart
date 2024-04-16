import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class AboutUsBodyWidget extends StatelessWidget {
  const AboutUsBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CheckPointWidget(
          onChanged: ({required isCheck}) {},
        ),
        KSizedBox.kHeightSizedBox30,
      ],
    );
  }
}
