import 'package:flutter/material.dart';

import 'package:veteranam/shared/shared_flutter.dart';

class SendingTextWidget extends StatelessWidget {
  const SendingTextWidget({
    required this.failureText,
    required this.sendingText,
    required this.successText,
    required this.textKey,
    this.showSendingText = false,
    this.showSuccessText = false,
    super.key,
    this.successTextAlign,
  });
  final String? failureText;
  final String? sendingText;
  final bool showSendingText;
  final String? successText;
  final bool showSuccessText;
  final Key textKey;
  final TextAlign? successTextAlign;

  @override
  Widget build(BuildContext context) {
    final sendingTextValue = showSendingText ? sendingText : null;
    final successTextValue = showSuccessText ? successText : null;
    if (failureText == null &&
        sendingTextValue == null &&
        successTextValue == null) {
      return const SizedBox.shrink();
    } else {
      return Padding(
        padding: const EdgeInsets.only(
          right: KPadding.kPaddingSize16,
          left: KPadding.kPaddingSize16,
          top: KPadding.kPaddingSize16,
        ),
        child: Text(
          (failureText ?? sendingTextValue ?? successTextValue)!,
          key: textKey,
          textAlign: showSuccessText
              ? successTextAlign ?? TextAlign.center
              : TextAlign.center,
          style: failureText != null
              ? AppTextStyle.materialThemeBodyMediumError
              : AppTextStyle.materialThemeBodyMediumNeutralVariant60,
        ),
      );
    }
  }
}
