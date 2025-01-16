part of 'body/story_add_body.dart';

List<Widget> _formWidgetList({
  required BuildContext context,
  required bool isDesk,
}) =>
    [
      if (isDesk)
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: KPadding.kPaddingSize32,
                ),
                child: Text(
                  context.l10n.yourStory,
                  key: StoryAddKeys.storyText,
                  style: AppTextStyle.text40,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: _message(context: context, isDesk: true),
            ),
          ],
        )
      else ...[
        Padding(
          padding: const EdgeInsets.only(left: KPadding.kPaddingSize16),
          child: Text(
            context.l10n.yourStory,
            key: StoryAddKeys.storyText,
            style: AppTextStyle.text24,
          ),
        ),
        KSizedBox.kHeightSizedBox8,
        _message(context: context, isDesk: false),
      ],
      if (isDesk) KSizedBox.kHeightSizedBox40 else KSizedBox.kHeightSizedBox24,
      if (isDesk)
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: KPadding.kPaddingSize32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.addPhoto,
                      key: StoryAddKeys.photoText,
                      style: AppTextStyle.text40,
                    ),
                    Text(
                      context.l10n.notNecessarily,
                      key: StoryAddKeys.photoDesciption,
                      style: AppTextStyle.hint20,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: _imageWidget(context),
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        )
      else ...[
        Padding(
          padding: const EdgeInsets.only(
            left: KPadding.kPaddingSize16,
          ),
          child: Row(
            spacing: KPadding.kPaddingSize4,
            children: [
              Text(
                context.l10n.addPhoto,
                key: StoryAddKeys.photoText,
                style: AppTextStyle.text24,
              ),
              Expanded(
                child: Text(
                  context.l10n.notNecessarily,
                  key: StoryAddKeys.photoDesciption,
                  style: AppTextStyle.hint16,
                ),
              ),
            ],
          ),
        ),
        KSizedBox.kHeightSizedBox16,
        _imageWidget(context),
      ],
    ];
