import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class ButtonSecondaryWidget extends StatelessWidget {
  const ButtonSecondaryWidget({
    required this.onPressed,
    required this.text,
    super.key,
    this.icon,
  });
  final void Function() onPressed;
  final String text;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: KPadding.kPaddingSize16,
          vertical: KPadding.kPaddingSize8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) icon!,
            KSizedBox.kHeightSizedBox3,
            Expanded(
              child: Text(
                text,
                style: AppTextStyle.text20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
