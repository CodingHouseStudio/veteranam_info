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
      titleTopMob: true,
      titleWidget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconWidget(
            key: KWidgetkeys.widget.storyCard.userIcon,
            icon: KIcon.person,
            background: AppColors.widgetBackground,
          ),
          KSizedBox.kWidthSizedBox3,
          Text(
            userName,
            key: KWidgetkeys.widget.storyCard.userName,
            style: AppTextStyle.text14,
          ),
        ],
      ),
      titleDate: Text(
        storyDate.toLocal().toString().split(' ')[0],
        key: KWidgetkeys.widget.storyCard.date,
        style: AppTextStyle.text16.copyWith(color: AppColors.lightGray),
      ),
      isDesk: true,
    );
  }
}
