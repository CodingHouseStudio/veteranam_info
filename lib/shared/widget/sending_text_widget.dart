import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class SendingTextWidget extends StatelessWidget {
  const SendingTextWidget({
    required this.failureText,
    required this.sendingText,
    required this.successText,
    required this.textKey,
    super.key,
  });
  final String? failureText;
  final String? sendingText;
  final String? successText;
  final Key textKey;

  @override
  Widget build(BuildContext context) {
    if (failureText == null && sendingText == null && successText == null) {
      return const SizedBox.shrink();
    } else {
      return Column(
        children: [
          KSizedBox.kHeightSizedBox16,
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: KPadding.kPaddingSize16,
            ),
            child: Text(
              (failureText ?? sendingText ?? successText)!,
              key: textKey,
              textAlign: TextAlign.center,
              style: failureText != null
                  ? AppTextStyle.materialThemeBodyMediumError
                  : AppTextStyle.materialThemeBodyMediumNeutralVariant60,
            ),
          ),
        ],
      );
    }
  }
}
