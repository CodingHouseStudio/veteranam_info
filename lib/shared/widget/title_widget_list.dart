import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

abstract class TitleWidget {
  static List<Widget> titleWidgetList({
    required String title,
    required Key titleKey,
    required String subtitle,
    required Key subtitleKey,
    required bool isDesk,
  }) =>
      [
        Text(
          title,
          key: titleKey,
          style: isDesk ? AppTextStyle.text96 : AppTextStyle.text32,
        ),
        KSizedBox.kHeightSizedBox8,
        Text(
          subtitle,
          key: subtitleKey,
          style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
        ),
      ];
}
