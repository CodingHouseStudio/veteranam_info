import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

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
    return CardTextDetailEvaluateWidget(
      image: storyModel.image,
      text: storyModel.story,
      titleTopMob: true,
      titleWidget: Row(
        children: [
          if (storyModel.userPhoto == null)
            IconWidget(
              key: KWidgetkeys.widget.storyCard.userIcon,
              icon: KIcon.person,
              background: AppColors.materialThemeKeyColorsNeutralVariant,
            )
          else
            ClipRRect(
              borderRadius: BorderRadius.circular(KSize.kUserPhoto),
              child: ImageWidget(
                imageUrl: storyModel.userPhoto!.downloadURL,
                fit: BoxFit.contain,
                size: KSize.kUserPhoto,
              ),
            ),
          KSizedBox.kWidthSizedBox8,
          Text(
            storyModel.userName ?? context.l10n.anonymous,
            key: KWidgetkeys.widget.storyCard.userName,
            style: AppTextStyle.text14,
          ),
        ],
      ),
      titleDate: Text(
        storyModel.date.localeTime,
        key: KWidgetkeys.widget.storyCard.date,
        style: AppTextStyle.hint16,
      ),
      isDesk: isDesk,
      titleIcon: KIcon.trash.copyWith(
        key: KWidgetkeys.widget.storyCard.trashIcon,
      ),
    );
  }
}
