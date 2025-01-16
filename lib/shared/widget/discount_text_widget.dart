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
    this.moreButtonEvent,
  });

  final String description;
  final List<EligibilityEnum>? eligibility;
  final int? maxLines;
  final Widget icon;
  final Widget button;
  final bool isDesk;
  final void Function()? moreButtonEvent;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '$description\n',
          key: CardTextDetailKeys.text,
          maxLines: maxLines ?? 2,
          style: AppTextStyle.materialThemeBodyLarge,
          overflow: TextOverflow.ellipsis,
        ),
        KSizedBox.kHeightSizedBox16,
        if (eligibility != null) ...[
          Text(
            context.l10n.eligibility,
            style: AppTextStyle.materialThemeLabelMediumVariant50,
          ),
          EligibilityWidget(
            isDesk: isDesk,
            eligibility: eligibility!,
            moreButtonEvent: moreButtonEvent,
          ),
          KSizedBox.kHeightSizedBox16,
        ],
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          runSpacing: KPadding.kPaddingSize16,
          children: [
            button,
            icon,
          ],
        ),
      ],
    );
  }
}
