import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kozak/shared/shared.dart';

class DiscountBodyWidget extends StatelessWidget {
  const DiscountBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      hasMicrophone: false,
      mainChildWidgetsFunction: ({required isDesk}) => [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            decoration: KWidgetTheme.boxDecorationWidget(context),
            child: Padding(
              padding: const EdgeInsets.all(KPadding.kPaddingSize10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...titleWidgetList(
                    title: context.l10n.discountsAndCoupons,
                    titleKey: null,
                    subtitle: context.l10n.discountsAndCouponsDescription,
                    subtitleKey: null,
                    isDesk: isDesk,
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
                          preInstructionDiscount:
                              KMockText.preInstructionDiscount,
                          isDesk: isDesk,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
