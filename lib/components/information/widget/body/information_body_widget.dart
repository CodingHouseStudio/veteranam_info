import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class InformationBodyWidget extends StatelessWidget {
  const InformationBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        KSizedBox.kHeightSizedBox30,
        NewsCardWidget(
          news: KMockText.cardData,
          newsDate: KMockText.date,
          title: KMockText.title,
        ),
        KSizedBox.kHeightSizedBox30,
      ],
    );
  }
}
