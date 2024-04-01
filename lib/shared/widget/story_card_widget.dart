import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:kozak/shared/shared.dart';

class StoryCardWidget extends StatelessWidget {
  const StoryCardWidget({
    required this.userPhoto,
    required this.userName,
    required this.storyDate,
    required this.story,
    this.image,
    super.key,
  });

  final String userPhoto;
  final String userName;
  final DateTime storyDate;
  final String story;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: KPadding.kPaddingSizeXL,
        vertical: image != null ? 0 : KPadding.kPaddingSizeXL,
      ),
      child: Row(
        key: KWidgetkeys.storyCardKeys.widget,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (image != null)
            Expanded(
              child: Container(
                decoration: KWidetTheme.boxDecorationImage,
                child: CachedNetworkImage(
                  key: KWidgetkeys.storyCardKeys.image,
                  imageUrl: image!,
                  placeholder: (context, url) => Image.asset(''),
                  errorWidget: (context, url, error) => KIcon.error,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          Expanded(
            child: _StoryCardWidgetImplementation(
              story: story,
              storyDate: storyDate,
              userName: userName,
              userPhoto: userPhoto,
            ),
          ),
        ],
      ),
    );
  }
}

class _StoryCardWidgetImplementation extends StatefulWidget {
  const _StoryCardWidgetImplementation({
    required this.userPhoto,
    required this.userName,
    required this.storyDate,
    required this.story,
  });

  final String userPhoto;
  final String userName;
  final DateTime storyDate;
  final String story;

  @override
  State<_StoryCardWidgetImplementation> createState() =>
      _StoryCardWidgetImplementationState();
}

class _StoryCardWidgetImplementationState
    extends State<_StoryCardWidgetImplementation>
    with TickerProviderStateMixin {
  late bool? like;
  // bool showFullStory = false;
  // late AnimationController _controller;
  // late Animation<int> _textAnimation;
  late int? maxLines;

  @override
  void initState() {
    super.initState();
    like = null;
    maxLines = 10;
    // _controller = AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 1000),
    // );
    // _textAnimation =
    //     IntTween(begin: 500, end: widget.story.length).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: KMinMaxSize.maxWidth640,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const IconWidget(
                      icon: KIcon.person,
                      background: AppColors.widgetBackground,
                    ),
                    KSizedBox.kWidthSizedBoxXS,
                    Text(
                      widget.userName,
                      key: KWidgetkeys.storyCardKeys.userName,
                      style: AppTextStyle.titleSmall,
                    ),
                  ],
                ),
                Text(
                  widget.storyDate.toLocal().toString().split(' ')[0],
                  key: KWidgetkeys.storyCardKeys.date,
                  style: AppTextStyle.titleMediumSmall
                      .copyWith(color: AppColors.lightGray),
                ),
              ],
            ),
            KSizedBox.kHeightSizedBoxSM,
            Text(
              widget.story,
              key: KWidgetkeys.storyCardKeys.text,
              maxLines: maxLines,
              style: AppTextStyle.lableSmall,
              overflow: TextOverflow.clip,
            ),
            // AnimatedBuilder(
            //   animation: _textAnimation,
            //   builder: (context, child) {
            //     late var text = '';
            //     if (showFullStory && _textAnimation.value > 500) {
            //       text = widget.story.substring(500, _textAnimation.value);
            //     }
            //     return Text(
            //       widget.story.substring(0, 500) + text,
            //       style: KAppTextStyle.lableSmall,
            //       overflow: TextOverflow.clip,
            //     );
            //   },
            // ),
            KSizedBox.kHeightSizedBoxSM,
            Align(
              alignment: Alignment.bottomLeft,
              child: TextButton(
                key: KWidgetkeys.storyCardKeys.button,
                onPressed: () {
                  setState(() {
                    maxLines == null ? maxLines = 10 : maxLines = null;
                    // showFullStory = !showFullStory;
                    // _controller.forward(from: 0);
                  });
                },
                style: KButtonStyles.whiteButtonStyleBorder,
                child: Text(
                  maxLines == null
                      ? KAppText.storyCardButtonNotDetail
                      : KAppText.storyCardButtonDetail,
                  style: AppTextStyle.lableMediumSmall,
                ),
              ),
            ),
            KSizedBox.kHeightSizedBoxSM,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      key: KWidgetkeys.storyCardKeys.likeIcon,
                      onTap: () => setState(() {
                        like == null || like == false
                            ? like = true
                            : like = null;
                      }),
                      child: like == null || !like!
                          ? KIcon.like
                          : KIcon.activeLike,
                    ),
                    KSizedBox.kWidthSizedBoxS,
                    Container(
                      key: KWidgetkeys.storyCardKeys.smileIcon,
                      child: KIcon.smile,
                    ),
                    KSizedBox.kWidthSizedBoxS,
                    InkWell(
                      key: KWidgetkeys.storyCardKeys.dislikeIcon,
                      onTap: () => setState(() {
                        like == null || like! == true
                            ? like = false
                            : like = null;
                      }),
                      child: like == null || like!
                          ? KIcon.dislike
                          : KIcon.activeDislike,
                    ),
                  ],
                ),
                Container(
                  key: KWidgetkeys.storyCardKeys.share,
                  child: KIcon.share,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
