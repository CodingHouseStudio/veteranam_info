import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

abstract class SectionWidget {
  static List<Widget> get({
    required bool isDesk,
    required String? textPoint,
    required String title,
    required String subtitle,
    required String textButton,
    required void Function()? route,
    required Key? prefixKey,
    required Key titleKey,
    required Key subtitleKey,
    required Key buttonKey,
    Widget? bottomWidget,
  }) =>
      [
        if (textPoint != null) ...[
          TextPointWidget(
            textPoint,
            key: prefixKey,
          ),
          if (isDesk)
            KSizedBox.kHeightSizedBox16
          else
            KSizedBox.kHeightSizedBox8,
        ],
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
        if (bottomWidget != null) bottomWidget,
      ];
}
