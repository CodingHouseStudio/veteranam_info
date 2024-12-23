import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class SecondaryButtonWidget extends StatelessWidget {
  const SecondaryButtonWidget({
    required this.isDesk,
    required this.text,
    required this.onPressed,
    required this.widgetKey,
    this.align,
    this.padding,
    this.style,
    super.key,
    this.expanded = true,
    this.hasAlign = true,
  });
  final Key widgetKey;
  final bool isDesk;
  final String text;
  final void Function()? onPressed;
  final Alignment? align;
  final EdgeInsetsGeometry? padding;
  final ButtonStyle? style;
  final bool expanded;
  final bool hasAlign;

  @override
  Widget build(BuildContext context) {
    if (hasAlign) {
      return Align(
        alignment: align ?? Alignment.centerLeft,
        child: _button,
      );
    } else {
      return _button;
    }
  }

  Widget get _button => TextButton(
        key: widgetKey,
        style: (expanded
                ? style
                : style?.copyWith(
                    minimumSize: expanded
                        ? const WidgetStatePropertyAll(
                            Size(
                              KMinMaxSize.maxWidth328,
                              0,
                            ),
                          )
                        : null,
                  )) ??
            (expanded
                ? KButtonStyles.borderSecondaryExpandButtonStyle
                : KButtonStyles.borderSecondaryButtonStyle),
        onPressed: onPressed,
        child: Padding(
          padding: padding ??
              const EdgeInsets.symmetric(
                vertical: KPadding.kPaddingSize12,
              ),
          child: Text(
            text,
            style: AppTextStyle.materialThemeTitleMedium,
          ),
        ),
      );
}
