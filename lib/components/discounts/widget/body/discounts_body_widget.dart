import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kozak/shared/shared.dart';

class DiscountBodyWidget extends StatelessWidget {
  const DiscountBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: KWidgetTheme.boxDecorationWidget(context),
        child: Padding(
          padding: const EdgeInsets.all(KPadding.kPaddingSize10),
          child: ScaffoldWidget(
            childWidgetsFunction: ({required isDesk}) => [
              Text(
                context.l10n.discountsAndCoupons,
                style: isDesk ? AppTextStyle.text96 : AppTextStyle.text32,
              ),
              Text(
                context.l10n.discountsAndCouponsDescription,
                style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
              ),
              if (isDesk)
                KSizedBox.kHeightSizedBox56
              else
                KSizedBox.kHeightSizedBox24,
              Padding(
                padding: EdgeInsets.all(
                  isDesk ? KPadding.kPaddingSize30 : 0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DiscountsCardWidget(
                      discount: KMockText.discount,
                      city: KMockText.cityDiscount,
                      service: KMockText.serviceDiscount,
                      description: KMockText.descriptionDiscount,
                      date: KMockText.dateDiscount,
                      instruction: KMockText.instructionDiscount,
                      preInstructionDiscount: KMockText.preInstructionDiscount,
                      isDesk: isDesk,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
