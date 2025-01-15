part of 'body/story_add_body.dart';

List<Widget> _buttonsWidgetList({
  required BuildContext context,
  required bool isDesk,
}) =>
    isDesk
        ? [
            Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        spacing: KPadding.kPaddingSize16,
                        children: [
                          SwitchWidget(
                            key: StoryAddKeys.switchAnonymously,
                            isSelected: context
                                .read<StoryAddBloc>()
                                .state
                                .isAnonymously,
                            onChanged: () => context.read<StoryAddBloc>().add(
                                  const StoryAddEvent.anonymouslyUpdated(),
                                ),
                          ),
                          Expanded(
                            child: Text(
                              context.l10n.publishAnonymously,
                              key: StoryAddKeys.switchText,
                              style: AppTextStyle.text24,
                            ),
                          ),
                        ],
                      ),
                      KSizedBox.kHeightSizedBox16,
                      Text(
                        context.l10n.publishAnonymouslyStorySubtitle,
                        key: StoryAddKeys.switchDescription,
                        style: AppTextStyle.hint24,
                      ),
                      KSizedBox.kHeightSizedBox40,
                      _button(context: context, isDesk: true),
                    ],
                  ),
                ),
              ],
            ),
          ]
        : [
            Row(
              spacing: KPadding.kPaddingSize16,
              children: [
                SwitchWidget(
                  key: StoryAddKeys.switchAnonymously,
                  isSelected: context.read<StoryAddBloc>().state.isAnonymously,
                  onChanged: () => context
                      .read<StoryAddBloc>()
                      .add(const StoryAddEvent.anonymouslyUpdated()),
                ),
                Expanded(
                  child: Text(
                    context.l10n.publishAnonymously,
                    key: StoryAddKeys.switchText,
                    style: AppTextStyle.text16,
                  ),
                ),
              ],
            ),
            KSizedBox.kHeightSizedBox16,
            Text(
              context.l10n.publishAnonymouslyStorySubtitle,
              key: StoryAddKeys.switchDescription,
              style: AppTextStyle.hint16,
            ),
            KSizedBox.kHeightSizedBox24,
            _button(context: context, isDesk: false),
          ];

Widget _button({
  required BuildContext context,
  required bool isDesk,
}) =>
    ButtonWidget(
      key: StoryAddKeys.button,
      text: context.l10n.publish,
      isDesk: isDesk,
      onPressed: () =>
          context.read<StoryAddBloc>().add(const StoryAddEvent.save()),
    );
