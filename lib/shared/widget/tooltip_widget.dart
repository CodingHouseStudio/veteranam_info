import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class TooltipWidget extends StatelessWidget {
  const TooltipWidget({
    required this.text,
    required this.duration,
    super.key,
    this.verticalOffset,
    this.margin,
  });
  final String text;
  final Duration duration;
  final double? verticalOffset;
  final double? margin;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: text,
      waitDuration: const Duration(milliseconds: 100),
      showDuration: duration,
      preferBelow: true,
      decoration: KWidgetTheme.boxDecorationTooltip,
      verticalOffset: verticalOffset ?? KSize.kPixel10,
      margin: EdgeInsets.symmetric(
        horizontal: margin ?? KPadding.kPaddingSize16,
      ),
      padding: const EdgeInsets.all(
        KPadding.kPaddingSize16,
      ),
      child: KIcon.info,
    );
  }
}
