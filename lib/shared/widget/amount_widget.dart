import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class AmountWidget extends StatelessWidget {
  const AmountWidget({
    required this.background,
    required this.textColor,
    required this.number,
    super.key,
    this.padding,
  });
  final Color background;
  final Color textColor;
  final int number;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(KPadding.kPaddingSize8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: background,
      ),
      child: Text(
        number.toString(),
        style: AppTextStyle.materialThemeLabelSmall.copyWith(
          color: textColor,
        ),
      ),
    );
  }
}
