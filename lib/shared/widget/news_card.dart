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
      bottom: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KSizedBox.kHeightSizedBox28,
          Wrap(
            spacing: KSize.kWrapSpacing8,
            runSpacing: KSize.kWrapRunSpacing4,
            children: KMockText.tags.map((tag) {
              return IgnorePointer(
                child: FilterChip(
                  key: KWidgetkeys.newsCardKeys.tags,
                  visualDensity: VisualDensity.compact,
                  showCheckmark: true,
                  label: Text(
                    tag,
                  ),
                  selectedColor: AppColors.widgetBackground,
                  checkmarkColor: AppColors.black,
                  selected: true,
                  labelStyle: AppTextStyle.lableXS,
                  onSelected: (value) {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(KSize.kRadiusM),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
