import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class ProfileMyStoryBodyWidget extends StatelessWidget {
  const ProfileMyStoryBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      mainChildWidgetsFunction: ({required isDesk}) => [
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
        ...List.generate(2, (index) {
          return Padding(
            padding: index != 0
                ? EdgeInsets.only(
                    top: isDesk
                        ? KPadding.kPaddingSize56
                        : KPadding.kPaddingSize24,
                  )
                : EdgeInsets.zero,
            child: StoryCardWidget(
              key: KWidgetkeys.screen.myStory.card,
              storyModel: KMockText.storyModel,
              isDesk: isDesk,
            ),
          );
        }),
        if (isDesk)
          KSizedBox.kHeightSizedBox56
        else
          KSizedBox.kHeightSizedBox24,
      ],
    );
  }
}
