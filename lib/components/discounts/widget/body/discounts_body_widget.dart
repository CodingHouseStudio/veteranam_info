import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class DiscountsBodyWidget extends StatelessWidget {
  const DiscountsBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        QuestionWidget(),
        FooterDescWidget(),
      ],
    );
  }
}
