import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kozak/shared/shared.dart';

class DiscountBodyWidget extends StatelessWidget {
  const DiscountBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      mainChildWidgetsFunction: ({required isDesk}) => [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            decoration: context.widgetTheme.boxDecorationWidget,
            child: Padding(
              padding: const EdgeInsets.all(KPadding.kPaddingSize10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...TitleWidget.titleWidgetList(
                    title: context.l10n.discountsAndCoupons,
                    titleKey: const Key('title'),
                    subtitle: context.l10n.discountsAndCouponsDescription,
                    subtitleKey: const Key('subtitle'),
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
                        Padding(
                          padding: (isDesk
                              ? const EdgeInsets.symmetric(
                                  horizontal: KPadding.kPaddingSize220,
                                )
                              : EdgeInsets.zero),
                          child: DiscountsCardWidget(
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
