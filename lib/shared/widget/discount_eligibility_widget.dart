import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountEligibilityWidget extends StatelessWidget {
  const DiscountEligibilityWidget({
    required this.eligibility,
    super.key,
  });

  final List<EligibilityEnum> eligibility;

  @override
  Widget build(BuildContext context) {
    if (eligibility.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(
          top: KPadding.kPaddingSize4,
          right: KPadding.kPaddingSize8,
        ),
        child: DiscountEligibilityExpandedWidget(
          key: ValueKey(eligibility),
          eligibility: eligibility,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

class DiscountEligibilityExpandedWidget extends StatelessWidget {
  const DiscountEligibilityExpandedWidget({
    required this.eligibility,
    super.key,
  });

  final List<EligibilityEnum> eligibility;

  @override
  Widget build(BuildContext context) {
    return RichText(
      key: KWidgetkeys.widget.cityList.markdownFulllList,
      text: TextSpan(
        style: AppTextStyle.materialThemeLabelLarge,
        children: _buildTextSpans(
          eligibility.length > 5 ? eligibility.take(5).toList() : eligibility,
          context,
        ),
      ),
    );
  }

  List<InlineSpan> _buildTextSpans(
    List<EligibilityEnum> eligibilityItems,
    BuildContext context,
  ) {
    final textSpans = <InlineSpan>[];

    for (final eligibilityItem in eligibilityItems) {
      textSpans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // _getIconWidget(text),
              eligibilityItem.eligibilityIcon,
              KSizedBox.kWidthSizedBox4,
              Text(
                // _getLabelWidget(text),
                eligibilityItem.getValue(context),
                style: AppTextStyle.materialThemeLabelMedium,
              ),
              KSizedBox.kWidthSizedBox8,
            ],
          ),
        ),
      );
    }

    if (eligibilityItems.length > 5) {
      textSpans.add(
        TextSpan(
          text: ' ${context.l10n.moreWhomGranted(eligibilityItems.length - 5)}',
          style: AppTextStyle.materialThemeLabelLargeRef,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              //context.goNamed();
            },
        ),
      );
    }

    return textSpans;
  }
}
