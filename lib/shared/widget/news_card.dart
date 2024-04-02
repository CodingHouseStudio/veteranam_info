import 'package:flutter/material.dart';

import 'package:kozak/shared/shared.dart';

class NewsCardWidget extends StatelessWidget {
  const NewsCardWidget({
    required this.newsDate,
    required this.news,
    required this.title,
    super.key,
    this.image,
  });
  final String title;
  final DateTime newsDate;
  final String news;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return CardTextDetailEvaluateWidget(
      image: image,
      text: news,
      buttonText: KAppText.newsDetailButton,
      buttonStyle: KButtonStyles.transparentButtonStyleBottomBorder,
      titleWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            key: KWidgetkeys.newsCardKeys.title,
            style: AppTextStyle.titleL,
          ),
          Text(
            newsDate.toLocal().toString().split(' ')[0],
            key: KWidgetkeys.newsCardKeys.date,
            style: AppTextStyle.titleS.copyWith(color: AppColors.lightGray),
          ),
        ],
      ),
      bottom: Wrap(
        spacing: KSize.kWrapSpacing8,
        runSpacing: KSize.kWrapRunSpacing4,
        children: KMockText.tags.map((tag) {
          return Container(
            key: KWidgetkeys.newsCardKeys.tags,
            decoration: KWidetTheme.boxDecorationCard,
            margin: const EdgeInsets.only(top: KPadding.kPaddingSize24),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: KPadding.kPaddingSize8,
                horizontal: KPadding.kPaddingSize4,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    tag,
                    style: AppTextStyle.lableXS,
                  ),
                  KIcon.check,
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
