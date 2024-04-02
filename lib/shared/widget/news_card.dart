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
    );
  }
}
