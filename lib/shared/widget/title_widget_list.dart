import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  static List<Widget> pointTitleWidgetList({
    required String title,
    required String titleSecondPart,
    required Key titleKey,
    required String pointText,
    required Key pointKey,
    required bool isDesk,
    CrossAxisAlignment titleCrossAxisAlignmentm = CrossAxisAlignment.stretch,
  }) =>
      isDesk
          ? [
              Row(
                children: [
                  Expanded(
                    child: TextPointWidget(
                      pointText,
                      key: pointKey,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      key: titleKey,
                      crossAxisAlignment: titleCrossAxisAlignmentm,
                      children: [
                        Text(
                          title,
                          style: AppTextStyle.materialThemeDisplayLarge,
                        ),
                        Row(
                          children: [
                            Text(
                              titleSecondPart,
                              style: AppTextStyle.materialThemeDisplayLarge,
                            ),
                            KSizedBox.kWidthSizedBox24,
                            IconWidget(
                              icon: KIcon.arrowDownRight.copyWith(
                                key: KWidgetkeys.screen.feedback.titleIcon,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              KSizedBox.kHeightSizedBox32,
              Divider(
                key: KWidgetkeys.screen.feedback.divider,
                color: AppColors.materialThemeKeyColorsNeutral,
              ),
            ]
          : [];
}
