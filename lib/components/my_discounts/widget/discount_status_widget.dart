import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountStatusWidget extends StatelessWidget {
  const DiscountStatusWidget({
    required this.status,
    required this.isDesk,
    super.key,
  });

  final DiscountState status;
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
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
              child: Column(
                children: [
                  TextPointWidget(
                    status.text(context),
                    textColor: status == DiscountState.deactivated
                        ? AppColors
                            .materialThemeRefNeutralVariantNeutralVariant40
                        : AppColors.materialThemeKeyColorsSecondary,
                    pointColor: status.pointColor,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (isDesk && status == DiscountState.rejected)
          Padding(
            padding: const EdgeInsets.only(top: KPadding.kPaddingSize4),
            child: Text(
              key: KWidgetkeys.screen.myDiscounts.rejectedText,
              context.l10n.descriptionForRejectedStatus,
              style: AppTextStyle.materialThemeLabelSmall,
            ),
          ),
      ],
    );
  }
}
