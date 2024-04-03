import 'package:flutter/material.dart';

import 'package:kozak/shared/shared.dart';

class StoryCardWidget extends StatelessWidget {
  const StoryCardWidget({
    required this.userName,
    required this.storyDate,
    required this.story,
    this.userPhoto,
    super.key,
    this.image,
  });

  final String? userPhoto;
  final String userName;
  final DateTime storyDate;
  final String story;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return CardTextDetailEvaluateWidget(
      image: image,
      text: story,
      titleWidget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                IconWidget(
                  key: KWidgetkeys.widget.storyCard.userIcon,
                  icon: KIcon.person,
                  background: AppColors.widgetBackground,
                ),
                KSizedBox.kWidthSizedBoxXS,
                Expanded(
                  child: Text(
                    userName,
                    key: KWidgetkeys.widget.storyCard.userName,
                    style: AppTextStyle.titleXS,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                storyDate.toLocal().toString().split(' ')[0],
                key: KWidgetkeys.widget.storyCard.date,
                style: AppTextStyle.titleS.copyWith(color: AppColors.lightGray),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
