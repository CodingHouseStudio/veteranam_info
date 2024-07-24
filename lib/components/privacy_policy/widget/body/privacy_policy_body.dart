import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class PrivacyPolicyBody extends StatelessWidget {
  const PrivacyPolicyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: KMinMaxSize.maxWidth768,
      ),
      padding: const EdgeInsets.symmetric(horizontal: KPadding.kPaddingSize32),
      child: RichText(
        key: KWidgetkeys.screen.privacyPolicy.text,
        text: TextSpan(
          children: context.l10n.privacyPolicyText
              // ignore: noop_primitive_operations
              .toString()
              .trim()
              .split('\n\n')
              .asMap()
              .entries
              .map((entry) {
            final index = entry.key;
            final paragraph = entry.value;
            late var textStyle = AppTextStyle.materialThemeBodyMedium;
            switch (index) {
              case 0:
                textStyle = AppTextStyle.materialThemeTitleLarge
                    .copyWith(fontWeight: FontWeight.bold);
              case 1:
              case 3:
              case 6:
              case 9:
              case 12:
              case 14:
              case 16:
              case 18:
                textStyle = AppTextStyle.materialThemeTitleMedium
                    .copyWith(fontWeight: FontWeight.w700);
            }
            return TextSpan(text: '$paragraph\n\n', style: textStyle);
          }).toList(), // Adjust font size as needed
        ),
      ),
    );
  }
}
