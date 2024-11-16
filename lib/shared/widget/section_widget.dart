import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class SectionWidget extends StatelessWidget {
  const SectionWidget({
    required this.isDesk,
    required this.route,
    required this.title,
    required this.subtitle,
    required this.textButton,
    required this.titleKey,
    required this.subtitleKey,
    required this.buttonKey,
    super.key,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.bottomWidget,
  });
  final bool isDesk;
  final CrossAxisAlignment crossAxisAlignment;
  final void Function() route;
  final String title;
  final String subtitle;
  final String textButton;
  final Key titleKey;
  final Key subtitleKey;
  final Key buttonKey;
  final Widget? bottomWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        // if (textPoint != null) ...[
        //   TextPointWidget(
        //     textPoint,
        //     key: prefixKey,
        //   ),
        //   if (isTablet)
        //     KSizedBox.kHeightSizedBox16
        //   else
        //     KSizedBox.kHeightSizedBox8,
        // ],
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            key: titleKey,
            style: isDesk
                ? AppTextStyle.materialThemeDisplayLarge
                : AppTextStyle.materialThemeDisplaySmall,
          ),
        ),
        if (isDesk) KSizedBox.kHeightSizedBox16 else KSizedBox.kHeightSizedBox8,
        Text(
          subtitle,
          key: subtitleKey,
          style: isDesk
              ? AppTextStyle.materialThemeBodyLarge
              : AppTextStyle.materialThemeBodyMedium,
        ),
        if (isDesk) KSizedBox.kHeightSizedBox16 else KSizedBox.kHeightSizedBox8,
        DoubleButtonWidget(
          widgetKey: buttonKey,
          text: textButton,
          onPressed: route,
          isDesk: isDesk,
        ),
        if (bottomWidget != null) bottomWidget!,
      ],
    );
  }
}
