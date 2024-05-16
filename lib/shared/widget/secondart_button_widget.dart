import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class SecondartButtonWidget extends StatelessWidget {
  const SecondartButtonWidget({
    required this.isDesk,
    required this.text,
    required this.onPressed,
    super.key,
  });
  final bool isDesk;
  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton.icon(
        style: KButtonStyles.secondaryButtonStyle(context),
        icon: KIcon.plus,
        onPressed: onPressed,
        label: Text(
          text,
          style: isDesk ? AppTextStyle.text20 : AppTextStyle.text16,
        ),
      ),
    );
  }
}
