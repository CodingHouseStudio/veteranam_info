import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class TooltipWidget extends StatelessWidget {
  const TooltipWidget({
    required this.description,
    required this.duration,
    required this.text,
    this.padding,
    super.key,
    this.verticalOffset,
    this.margin,
    this.child,
    this.waitDuration = const Duration(milliseconds: 100),
  });
  final String description;
  final Duration duration;
  final Duration waitDuration;
  final double? verticalOffset;
  final double? margin;
  final EdgeInsets? padding;
  final String text;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: description,
      triggerMode: TooltipTriggerMode.tap,
      waitDuration: waitDuration,
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
      child: child ??
          Padding(
            padding: padding ??
                const EdgeInsets.only(
                  top: KPadding.kPaddingSize12,
                  bottom: KPadding.kPaddingSize12,
                  right: KPadding.kPaddingSize12,
                ),
            child: Row(
              children: [
                Text(
                  text,
                  style: AppTextStyle.materialThemeTitleMedium,
                ),
                KSizedBox.kWidthSizedBox8,
                KIcon.info,
              ],
            ),
          ),
    );
  }
}
