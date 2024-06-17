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
  static List<Widget> pointTitleWidgetList({
    required String title,
    required String titleSecondPart,
    required Key titleKey,
    required String pointText,
    required Key pointKey,
    required bool isDesk,
    EdgeInsets titleSecondPartPadding = EdgeInsets.zero,
    bool isRightArrow = true,
    WrapAlignment titleAlignment = WrapAlignment.start,
    CrossAxisAlignment iconCrossAxisAlignment = CrossAxisAlignment.start,
    TextAlign textAlign = TextAlign.start,
  }) =>
      [
        if (isDesk)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      title,
                      textAlign: textAlign,
                      style: AppTextStyle.materialThemeDisplayLarge,
                    ),
                    Padding(
                      padding: titleSecondPartPadding,
                      child: Wrap(
                        alignment: titleAlignment,
                        children: [
                          Text(
                            titleSecondPart,
                            style: AppTextStyle.materialThemeDisplayLarge,
                            textAlign: textAlign,
                          ),
                          KSizedBox.kWidthSizedBox24,
                          IconWidget(
                            // key: KWidgetkeys.screen.feedback.titleIcon,
                            icon: isRightArrow
                                ? KIcon.arrowDownRight
                                : KIcon.arrowDownLeft,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        else ...[
          TextPointWidget(
            pointText,
            key: pointKey,
          ),
          KSizedBox.kHeightSizedBox16,
          Row(
            key: titleKey,
            crossAxisAlignment: iconCrossAxisAlignment,
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  '$title $titleSecondPart',
                  style: AppTextStyle.materialThemeDisplaySmall,
                ),
              ),
              IconWidget(
                // key: KWidgetkeys.screen.feedback.titleIcon,
                icon: isRightArrow ? KIcon.arrowDownRight : KIcon.arrowDownLeft,
                padding:
                    isDesk ? KPadding.kPaddingSize20 : KPadding.kPaddingSize12,
              ),
            ],
          ),
        ],
        KSizedBox.kHeightSizedBox32,
        const Divider(
          color: AppColors.materialThemeKeyColorsNeutral,
        ),
      ];
}
