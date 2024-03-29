import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class StoryBodyWidget extends StatelessWidget {
  const StoryBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        FooterDescWidget(),
      ],
    );
  }
}
