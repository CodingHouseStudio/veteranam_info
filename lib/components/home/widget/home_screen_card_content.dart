import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

abstract class HomeScreenCardContent {
  static List<Widget> get({
    required bool isDesk,
    required String textPoint,
    required String title,
    required String subtitle,
    required String textButton,
    required void Function()? route,
    required Key prefixKey,
    required Key titleKey,
    required Key subtitleKey,
    required Key buttonKey,
    Widget? bottomWidget,
  }) =>
      [
        if (!isDesk) KSizedBox.kHeightSizedBox16,
        TextPointWidget(
          textPoint,
          key: prefixKey,
        ),
        if (isDesk) KSizedBox.kHeightSizedBox16 else KSizedBox.kHeightSizedBox8,
        Text(
          title,
          key: titleKey,
          style: AppTextStyle.materialThemeDisplayLarge,
        ),
        if (isDesk) KSizedBox.kHeightSizedBox16 else KSizedBox.kHeightSizedBox8,
        Text(
          subtitle,
          key: subtitleKey,
          style: AppTextStyle.materialThemeBodyLarge,
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
