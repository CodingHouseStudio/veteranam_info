import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

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
        spacing: KPadding.kPaddingSize8,
        children: [
          storyModel.getImage,
          Text(
            storyModel.userName ?? context.l10n.anonymous,
            key: StoryCardKeys.userName,
            style: AppTextStyle.text14,
          ),
        ],
      ),
      titleDate: Text(
        storyModel.date.localeTime,
        key: StoryCardKeys.date,
        style: AppTextStyle.hint16,
      ),
      isDesk: isDesk,
      titleIcon: KIcon.trash.copyWith(
        key: StoryCardKeys.trashIcon,
      ),
      cardId: storyModel.id,
      cardEnum: CardEnum.story,
    );
  }
}
