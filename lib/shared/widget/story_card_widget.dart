import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class StoryCardWidget extends StatelessWidget {
  const StoryCardWidget({
    required this.storyModel,
    required this.isDesk,
    super.key,
  });

  final StoryModel storyModel;
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isDesk
          ? const EdgeInsets.symmetric(horizontal: KPadding.kPaddingSize48)
          : EdgeInsets.zero,
      child: CardTextDetailEvaluateWidget(
        image: storyModel.image.firstImage,
        text: storyModel.story,
        titleTopMob: true,
        titleWidget: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconWidget(
              key: KWidgetkeys.widget.storyCard.userIcon,
              icon: KIcon.person,
              // background: AppColors.widgetBackground,
            ),
            KSizedBox.kWidthSizedBox3,
            Text(
              storyModel.userName,
              key: KWidgetkeys.widget.storyCard.userName,
              style: AppTextStyle.text14,
            ),
          ],
        ),
        titleDate: Text(
          storyModel.date.localeTime,
          key: KWidgetkeys.widget.storyCard.date,
          style: AppTextStyle.text16.copyWith(
              // color: AppColors.lightGray,
              ),
        ),
        isDesk: isDesk,
      ),
    );
  }
}
