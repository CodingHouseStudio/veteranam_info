import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountTextWidget extends StatelessWidget {
  const DiscountTextWidget({
    required this.isDesk,
    required this.description,
    required this.icon,
    required this.button,
    this.maxLines,
    this.eligibility,
    super.key,
  });

  final String description;
  final List<EligibilityEnum>? eligibility;
  final int? maxLines;
  final Widget icon;
  final Widget button;
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          description,
          key: KWidgetkeys.widget.cardTextDetail.text,
          maxLines: maxLines ?? 2,
          style: AppTextStyle.materialThemeBodyLarge,
          overflow: TextOverflow.ellipsis,
        ),
        KSizedBox.kHeightSizedBox16,
        if (eligibility != null) ...[
          Text(
            context.l10n.eligibility,
            style: AppTextStyle.materialThemeLabelMedium.copyWith(
              color: AppColors.materialThemeRefNeutralVariantNeutralVariant50,
            ),
          ),
          EligibilityWidget(eligibility: eligibility!),
          KSizedBox.kHeightSizedBox16,
        ],
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            button,
            icon,
          ],
        ),
      ],
    );
  }
}