import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    required this.title,
    required this.titleKey,
    required this.subtitle,
    required this.subtitleKey,
    required this.isDesk,
    super.key,
  });

  final String title;
  final Key titleKey;
  final String subtitle;
  final Key subtitleKey;
  final bool isDesk;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
      ],
    );
  }
}

class TitleIconWidget extends StatelessWidget {
  const TitleIconWidget({
    required this.title,
    required this.titleKey,
    required this.isDesk,
    required this.titleSecondPart,
    this.iconCrossAxisAlignment = CrossAxisAlignment.end,
    super.key,
  });
  final String title;
  final Key titleKey;
  final bool isDesk;
  final String titleSecondPart;
  // bool isRightArrow = true;
  final CrossAxisAlignment iconCrossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isDesk)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const IconWidget(
                // key: KWidgetkeys.screen.feedback.titleIcon,
                icon: KIcon.arrowDownRight,
              ),
              KSizedBox.kWidthSizedBox90,
              Expanded(
                child: Column(
                  key: titleKey,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      title,
                      style: AppTextStyle.materialThemeDisplayLarge,
                    ),
                    Text(
                      titleSecondPart,
                      style: AppTextStyle.materialThemeDisplayLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          )
        else ...[
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
                icon: KIcon.arrowDownLeft,
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
      ],
    );
  }
}

class LineTitleIconWidget extends StatelessWidget {
  const LineTitleIconWidget({
    required this.title,
    required this.titleKey,
    // required this.isDesk,
    this.iconCrossAxisAlignment = CrossAxisAlignment.end,
    super.key,
  });
  final String title;
  final Key titleKey;
  // final bool isDesk;
  // bool isRightArrow = true;
  final CrossAxisAlignment iconCrossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // if (isDesk)
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyle.materialThemeDisplayLarge,
            ),
            KSizedBox.kWidthSizedBox32,
            const IconWidget(
              // key: KWidgetkeys.screen.feedback.titleIcon,
              icon: KIcon.arrowDownRight,
            ),
          ],
        ),
        // else
        //   Row(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       const IconWidget(
        //         // key: KWidgetkeys.screen.feedback.titleIcon,
        //         icon: KIcon.arrowDownRight,
        //       ),
        //       KSizedBox.kWidthSizedBox16,
        //       Expanded(
        //         child: Text(
        //           title,
        //           style: AppTextStyle.materialThemeDisplaySmall,
        //         ),
        //       ),
        //     ],
        //   ),
        KSizedBox.kHeightSizedBox32,
        const Divider(
          color: AppColors.materialThemeKeyColorsNeutral,
        ),
      ],
    );
  }
}

class TitlePointWidget extends StatelessWidget {
  const TitlePointWidget({
    required this.title,
    required this.titleSecondPart,
    required this.titleKey,
    required this.isDesk,
    super.key,
    this.titleSecondPartPadding = EdgeInsets.zero,
    this.isRightArrow = true,
    this.titleAlignment = WrapAlignment.start,
    this.iconCrossAxisAlignment = CrossAxisAlignment.start,
    this.textAlign = TextAlign.start,
  });
  final String title;
  final String titleSecondPart;
  final Key titleKey;
  // final String pointText;
  // final Key pointKey;
  final bool isDesk;
  final EdgeInsets titleSecondPartPadding;
  final bool isRightArrow;
  final WrapAlignment titleAlignment;
  final CrossAxisAlignment iconCrossAxisAlignment;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isDesk)
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Expanded(
          //       child: TextPointWidget(
          //         pointText,
          //         key: pointKey,
          //       ),
          //     ),
          //     Expanded(
          //       flex: 4,
          //       child:
          Column(
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
          )
        //     ),
        //   ],
        // )
        else
          // TextPointWidget(
          //   pointText,
          //   key: pointKey,
          // ),
          // KSizedBox.kHeightSizedBox16,
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
        KSizedBox.kHeightSizedBox32,
        const Divider(
          color: AppColors.materialThemeKeyColorsNeutral,
        ),
      ],
    );
  }
}

class ShortTitleIconWidget extends StatelessWidget {
  const ShortTitleIconWidget({
    required this.title,
    required this.titleKey,
    required this.isDesk,
    this.iconCrossAxisAlignment = CrossAxisAlignment.end,
    this.firstIcon = false,
    this.icon,
    super.key,
    this.expanded = false,
  });
  final String title;
  final Key titleKey;
  final bool isDesk;
  final CrossAxisAlignment iconCrossAxisAlignment;
  final bool expanded;
  final Icon? icon;
  final bool firstIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (firstIcon) ...[
          iconWidget,
          if (!expanded) spacer,
        ],
        if (expanded) Expanded(child: text) else text,
        if (!expanded) spacer,
        if (!firstIcon) iconWidget,
      ],
    );
  }

  Widget get spacer {
    if (isDesk) {
      return KSizedBox.kWidthSizedBox32;
    } else {
      if (firstIcon) {
        return KSizedBox.kWidthSizedBox16;
      } else {
        return KSizedBox.kWidthSizedBox24;
      }
    }
  }

  Widget get text => Text(
        title,
        key: titleKey,
        style: isDesk
            ? AppTextStyle.materialThemeDisplayLarge
            : AppTextStyle.materialThemeDisplaySmall,
      );

  Widget get iconWidget => IconWidget(
        icon: icon ?? KIcon.arrowDownLeft,
        padding: isDesk ? KPadding.kPaddingSize20 : KPadding.kPaddingSize8,
      );
}
