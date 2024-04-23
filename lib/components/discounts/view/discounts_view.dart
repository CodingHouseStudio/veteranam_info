import 'package:flutter/material.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class DiscountsScreen extends StatelessWidget {
  const DiscountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      childWidgetsFunction: ({required isDesk}) => [
        KSizedBox.kHeightSizedBox16,
        DiscountsBodyWidget(
          key: KWidgetkeys.screen.discounts.screen,
          discount: KMockText.discount,
          city: KMockText.cityDiscount,
          service: KMockText.serviceDiscount,
          description: KMockText.descriptionDiscount,
          date: KMockText.dateDiscount,
          instruction: KMockText.instructionDiscount,
        ),
        KSizedBox.kHeightSizedBox16,
      ],
    );
  }
}
