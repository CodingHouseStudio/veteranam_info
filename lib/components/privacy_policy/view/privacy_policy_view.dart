import 'package:flutter/material.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

class PrivacyPolicyDialog extends StatelessWidget {
  const PrivacyPolicyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: KMinMaxSize.maxWidth768),
        child: Dialog(
          key: KWidgetkeys.screen.privacyPolicy.dialog,
          shape: KWidgetTheme.outlineBorder,
          backgroundColor: AppColors.materialThemeKeyColorsNeutral,
          insetPadding: const EdgeInsets.all(KPadding.kPaddingSize16),
          child: const PrivacyPolicyBlocprovider(
            widgetChild: PrivacyPolicyBody(),
          ),
        ),
      ),
    );
  }
}
