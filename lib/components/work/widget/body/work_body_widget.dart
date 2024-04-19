import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class WorkBodyWidget extends StatelessWidget {
  const WorkBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithNavBar(
      childWidgetsFunction: ({required isDesk}) => [
        KSizedBox.kHeightSizedBox30,
        const WorkCardWidget(
          title: KMockText.workTitle,
          city: KMockText.workCity,
          price: KMockText.workPrice,
          description: KMockText.workDescription,
          employer: KMockText.workEmployer,
        ),
        KSizedBox.kHeightSizedBox30,
      ],
    );
  }
}
