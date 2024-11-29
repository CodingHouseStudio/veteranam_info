import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountTextWidget extends StatelessWidget {
  const DiscountTextWidget({
    required this.isDesk,
    required this.description,
    this.text,
    this.maxLines,
    this.icon,
    this.button,
    super.key,
  });

  final String description;
  final List<TranslateModel>? text;
  final int? maxLines;
  final Widget? icon;
  final Widget? button;
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
        if (text != null) ...[
          Text(
            context.l10n.eligibility,
            style: AppTextStyle.materialThemeLabelMedium.copyWith(
              color: AppColors.materialThemeRefNeutralVariantNeutralVariant50,
            ),
          ),
          Eligibility(text: text!.getTrsnslation(context)),
          KSizedBox.kHeightSizedBox16,
        ],
        if (icon != null && button != null)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              button!,
              icon!,
            ],
          ),
      ],
    );
  }
}
