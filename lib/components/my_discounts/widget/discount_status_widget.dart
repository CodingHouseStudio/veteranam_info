import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class DiscountStatusWidget extends StatelessWidget {
  const DiscountStatusWidget({
    required this.status,
    super.key,
  });

  final DiscountState status;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: DecoratedBox(
        decoration: KWidgetTheme.boxDecorationDiscount.copyWith(
          color: status.color,
        ),
        // alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: KPadding.kPaddingSize8,
            vertical: KPadding.kPaddingSize4,
          ),
          child: TextPointWidget(
            status.text(context),
            textColor: status == DiscountState.deactivated
                ? AppColors.materialThemeRefNeutralVariantNeutralVariant40
                : AppColors.materialThemeKeyColorsSecondary,
            pointColor: status.pointColor,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
          ),
        ),
      ),
    );
  }
}
