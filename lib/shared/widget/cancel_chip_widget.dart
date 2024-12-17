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
    this.width,
  });
  final Key widgetKey;
  final bool isDesk;
  final String labelText;
  final void Function()? onPressed;
  final ButtonStyle? style;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      key: widgetKey,
      style: (style ?? KButtonStyles.advancedFilterButtonStyle).copyWith(
        padding: padding == null ? null : WidgetStatePropertyAll(padding),
        maximumSize: width == null
            ? null
            : WidgetStatePropertyAll(Size(width!, double.infinity)),
        minimumSize:
            width == null ? null : WidgetStatePropertyAll(Size(width!, 0)),
      ),
      icon: KIcon.close,
      clipBehavior: Clip.hardEdge,
      label: width == null
          ? textWidget
          : Expanded(
              child: textWidget,
            ),
      onPressed: onPressed,
    );
  }

  Widget get textWidget => Text(
        labelText,
        textAlign: width == null ? TextAlign.center : TextAlign.end,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: textStyle ??
            (isDesk
                ? AppTextStyle.materialThemeBodyLarge
                : AppTextStyle.materialThemeBodyMedium),
      );
}
