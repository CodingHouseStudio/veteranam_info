import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class FeedbackTitle extends StatelessWidget {
  const FeedbackTitle({
    required this.isDesk,
    required this.title,
    required this.secondText,
    super.key,
    this.titleSecondPart,
    this.text,
  });
  final bool isDesk;
  final String title;
  final String? titleSecondPart;
  final String? text;
  final String secondText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: isDesk
          ? [
              KSizedBox.kHeightSizedBox24,
              if (titleSecondPart != null)
                TitlePointWidget(
                  isDesk: true,
                  //pointText: context.l10n.feedback,
                  // pointKey: KWidgetkeys.screen.feedback.pointText,
                  title: title,
                  titleSecondPart: titleSecondPart!,
                  titleKey: KWidgetkeys.screen.feedback.title,
                )
              else
                ShortTitleIconWidget(
                  title: title,
                  titleKey: KWidgetkeys.screen.feedback.title,
                  isDesk: isDesk,
                ),
              KSizedBox.kHeightSizedBox100,
            ]
          : [
              // KSizedBox.kHeightSizedBox24,
              // TextPointWidget(
              //   context.l10n.feedback,
              //   key: KWidgetkeys.screen.feedback.pointText,
              // ),
              KSizedBox.kHeightSizedBox16,
              if (text != null)
                Text(
                  text!,
                  style: AppTextStyle.materialThemeDisplaySmall,
                ),
              Row(
                key: KWidgetkeys.screen.feedback.title,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const IconWidget(
                    icon: KIcon.arrowDownRight,
                    padding: KPadding.kPaddingSize12,
                  ),
                  KSizedBox.kWidthSizedBox16,
                  Expanded(
                    child: Text(
                      secondText,
                      style: AppTextStyle.materialThemeDisplaySmall,
                    ),
                  ),
                ],
              ),
              KSizedBox.kHeightSizedBox32,
              const Divider(
                color: AppColors.materialThemeKeyColorsNeutral,
              ),
              KSizedBox.kHeightSizedBox24,
            ],
    );
  }
}