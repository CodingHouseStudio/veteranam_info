import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class SecondaryButtonWidget extends StatelessWidget {
  const SecondaryButtonWidget({
    required this.isDesk,
    required this.text,
    required this.onPressed,
    required this.widgetKey,
    super.key,
    this.align,
    this.padding,
  });
  final Key widgetKey;
  final bool isDesk;
  final String text;
  final void Function()? onPressed;
  final Alignment? align;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: align ?? Alignment.centerLeft,
      child: TextButton(
        key: widgetKey,
        style: KButtonStyles.borderSecondaryButtonStyle.copyWith(
          minimumSize: const WidgetStatePropertyAll(
            Size(
              KMinMaxSize.maxWidth328,
              0,
            ),
          ),
        ),
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
      ),
    );
  }
}
