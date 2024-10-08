import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared.dart';

class MyDiscountEmptyWidget extends StatelessWidget {
  const MyDiscountEmptyWidget({
    required this.isDesk,
    super.key,
  });
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        KImage.discountEmpty(
          key: KWidgetkeys.screen.myDiscounts.iconEmpty,
        ),
        KSizedBox.kHeightSizedBox16,
        Text(
          context.l10n.publishDiscount,
          style: isDesk
              ? AppTextStyle.materialThemeTitleLargeNeutral80
              : AppTextStyle.materialThemeTitleSmallNeutral80,
        ),
        KSizedBox.kHeightSizedBox40,
        DoubleButtonWidget(
          text: context.l10n.addDiscount,
          isDesk: isDesk,
          onPressed: () => context.goNamed(KRoute.discountsAdd.name),
          icon: KIcon.plus,
          widgetKey: KWidgetkeys.screen.myDiscounts.buttonAdd,
          deskPadding: const EdgeInsets.symmetric(
            vertical: KPadding.kPaddingSize16,
            horizontal: KPadding.kPaddingSize64,
          ),
          angle: pi / 2,
          deskIconPadding: KPadding.kPaddingSize16,
          align: Alignment.center,
          mobIconPadding: KPadding.kPaddingSize16,
          mobHorizontalTextPadding: KPadding.kPaddingSize60,
          mobVerticalTextPadding: KPadding.kPaddingSize16,
        ),
      ],
    );
  }
}
