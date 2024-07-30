import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
      contentPadding: EdgeInsets.zero,
      content: Stack(
        children: [
          const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: KPadding.kPaddingSize40,
              ),
              child:
                  PrivacyPolicyBlocprovider(widgetChild: PrivacyPolicyBody()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(KPadding.kPaddingSize16),
            child: CancelWidget(
              widgetKey: KWidgetkeys.screen.privacyPolicy.closeIcon,
              onPressed: () => context.goNamed(KRoute.home.name),
            ),
          ),
        ],
      ),
    );
  }
}
