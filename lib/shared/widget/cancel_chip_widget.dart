import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class CancelChipWidget extends StatelessWidget {
  const CancelChipWidget({
    required this.widgetKey,
    required this.isDesk,
    required this.labelText,
    required this.onPressed,
    super.key,
    this.style,
    this.textStyle,
    this.padding,
  });
  final Key widgetKey;
  final bool isDesk;
  final String labelText;
  final void Function()? onPressed;
  final ButtonStyle? style;
  final TextStyle? textStyle;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      key: widgetKey,
      style: (style ?? KButtonStyles.advancedFilterButtonStyle).copyWith(
        padding: padding == null ? null : WidgetStatePropertyAll(padding),
      ),
      icon: KIcon.close,
      clipBehavior: Clip.hardEdge,
      label: Text(
        labelText,
        textAlign: TextAlign.center,
        maxLines: 1,
        style: textStyle ??
            (isDesk
                ? AppTextStyle.materialThemeBodyLarge
                : AppTextStyle.materialThemeBodyMedium),
      ),
      onPressed: onPressed,
    );
  }
}
