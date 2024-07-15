import 'package:flutter/material.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

class PrivacyPolicyDialog extends StatelessWidget {
  const PrivacyPolicyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: KWidgetkeys.screen.privacyPolicy.dialog,
      shape: const RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
      ),
      backgroundColor: AppColors.materialThemeKeyColorsNeutral,
      icon: CancelWidget(
        widgetKey: KWidgetkeys.screen.privacyPolicy.icon,
      ),
      contentPadding: EdgeInsets.zero,
      iconPadding: const EdgeInsets.only(
        top: KPadding.kPaddingSize16,
        right: KPadding.kPaddingSize16,
      ),
      scrollable: true,
      content: const PrivacyPolicyBody(),
    );
  }
}
