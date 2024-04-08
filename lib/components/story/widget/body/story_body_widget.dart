import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class StoryBodyWidget extends StatelessWidget {
  const StoryBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        KSizedBox.kHeightSizedBox30,
        StoryCardWidget(
          storyDate: KMockText.date,
          userName: KMockText.userNameAnonim,
          story: KMockText.cardData,
        ),
        KSizedBox.kHeightSizedBox30,
      ],
    );
  }
}
