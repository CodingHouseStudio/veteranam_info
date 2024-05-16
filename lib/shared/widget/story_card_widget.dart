import 'package:cached_network_image/cached_network_image.dart';
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
          children: [
            if (storyModel.userPhoto == null)
              IconWidget(
                key: KWidgetkeys.widget.storyCard.userIcon,
                icon: KIcon.person,
                background: context.color.onPrimary,
              )
            else
              ClipRRect(
                borderRadius: BorderRadius.circular(KSize.kUserPhoto),
                child: CachedNetworkImage(
                  imageUrl: storyModel.userPhoto.firstImage!,
                  placeholder: (context, url) => Image.asset(''),
                  errorWidget: (context, url, error) => KIcon.error,
                  fit: BoxFit.contain,
                  width: KSize.kUserPhoto,
                  height: KSize.kUserPhoto,
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
          style: AppTextStyle.text16.copyWith(
              // color: AppColors.lightGray,
              ),
        ),
        isDesk: isDesk,
      ),
    );
  }
}
