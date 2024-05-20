import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class ProfileMyStoryBodyWidget extends StatelessWidget {
  const ProfileMyStoryBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      mainChildWidgetsFunction: ({required isDesk}) => [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isDesk)
              KSizedBox.kHeightSizedBox40
            else
              KSizedBox.kHeightSizedBox24,
            Text(
              context.l10n.myStory,
              key: KWidgetkeys.screen.myStory.title,
              style: isDesk ? AppTextStyle.text96 : AppTextStyle.text32,
            ),
            KSizedBox.kHeightSizedBox8,
            Text(
              context.l10n.myStoryDetails,
              key: KWidgetkeys.screen.myStory.subtitle,
              style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
            ),
            if (isDesk)
              KSizedBox.kHeightSizedBox56
            else
              KSizedBox.kHeightSizedBox24,
            ...List.generate(2, (index) {
              return Padding(
                padding: EdgeInsets.only(
                  top: index != 0 ? KPadding.kPaddingSize40 : 0,
                ),
                child: StoryCardWidget(
                  key: KWidgetkeys.screen.myStory.card,
                  storyModel: KMockText.storyModel,
                  isDesk: isDesk,
                ),
              );
            }),

            // if (isDesk)
            //   KSizedBox.kHeightSizedBox56
            // else
            //   KSizedBox.kHeightSizedBox24,
            // StoryCardWidget(
            //   key: KWidgetkeys.screen.myStory.card,
            //   storyDate: KMockText.date,
            //   userName: KMockText.userNameAnonim,
            //   story: KMockText.cardData,
            //   userPhoto: KMockText.image,
            // ),
            if (isDesk)
              KSizedBox.kHeightSizedBox56
            else
              KSizedBox.kHeightSizedBox24,
          ],
        ),
      ],
    );
  }
}
