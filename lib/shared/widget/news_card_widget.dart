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
      buttonText: [
        context.l10n.readMore,
        context.l10n.readLess,
      ],
      buttonStyle: KButtonStyles.transparentButtonStyleBottomBorder,
      titleWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            key: KWidgetkeys.widget.newsCard.title,
            style: AppTextStyle.text40,
          ),
          Text(
            newsDate.toLocal().toString().split(' ')[0],
            key: KWidgetkeys.widget.newsCard.date,
            style: AppTextStyle.text16.copyWith(color: AppColors.lightGray),
          ),
        ],
      ),
      bottom: Wrap(
        spacing: KSize.kWrapSpacing8,
        runSpacing: KSize.kWrapRunSpacing4,
        children: KMockText.tags.map((tag) {
          return Container(
            key: KWidgetkeys.widget.newsCard.tags,
            decoration: KWidetTheme.boxDecorationCard,
            margin: const EdgeInsets.only(top: KPadding.kPaddingSize24),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: KPadding.kPaddingSize4,
                horizontal: KPadding.kPaddingSize8,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    tag,
                    style: AppTextStyle.text14,
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
