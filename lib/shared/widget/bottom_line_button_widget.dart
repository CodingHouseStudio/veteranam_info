import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class BottomLineButtonWidget extends StatefulWidget {
  const BottomLineButtonWidget({
    required this.text,
    required this.onPressed,
    super.key,
    this.icon,
  });

  final String text;
  final Widget? icon;
  final void Function() onPressed;

  @override
  State<BottomLineButtonWidget> createState() => _BottomLineButtonWidgetState();
}

class _BottomLineButtonWidgetState extends State<BottomLineButtonWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      style: KButtonStyles.doubleButtonStyle,
      onHover: (value) => setState(() => _isHovered = value),
      child: IntrinsicWidth(
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  widget.text,
                  style: AppTextStyle.materialThemeTitleMedium,
                ),
                if (widget.icon != null) ...[
                  KSizedBox.kWidthSizedBox8,
                  widget.icon!,
                ],
                KSizedBox.kWidthSizedBox4,
              ],
            ),
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              width: _isHovered ? double.infinity : 0,
              decoration: const BoxDecoration(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
