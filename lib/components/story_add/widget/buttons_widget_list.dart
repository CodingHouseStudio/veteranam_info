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
                        children: [
                          SwitchWidget(
                            key: KWidgetkeys.screen.storyAdd.switchAnonymously,
                            isSelected: context
                                .read<StoryAddBloc>()
                                .state
                                .isAnonymously,
                            onChanged: (p0) => context.read<StoryAddBloc>().add(
                                  const StoryAddEvent.anonymouslyUpdated(),
                                ),
                          ),
                          KSizedBox.kWidthSizedBox16,
                          Expanded(
                            child: Text(
                              context.l10n.publishAnonymously,
                              key: KWidgetkeys.screen.storyAdd.switchText,
                              style: AppTextStyle.text24,
                            ),
                          ),
                        ],
                      ),
                      KSizedBox.kHeightSizedBox16,
                      Text(
                        context.l10n.publishAnonymouslyStorySubtitle,
                        key: KWidgetkeys.screen.storyAdd.switchDescription,
                        style: context.textStyle.hint24,
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
              children: [
                SwitchWidget(
                  key: KWidgetkeys.screen.storyAdd.switchAnonymously,
                  isSelected: context.read<StoryAddBloc>().state.isAnonymously,
                  onChanged: (p0) => context
                      .read<StoryAddBloc>()
                      .add(const StoryAddEvent.anonymouslyUpdated()),
                ),
                KSizedBox.kWidthSizedBox16,
                Expanded(
                  child: Text(
                    context.l10n.publishAnonymously,
                    key: KWidgetkeys.screen.storyAdd.switchText,
                    style: AppTextStyle.text16,
                  ),
                ),
              ],
            ),
            KSizedBox.kHeightSizedBox16,
            Text(
              context.l10n.publishAnonymouslyStorySubtitle,
              key: KWidgetkeys.screen.storyAdd.switchDescription,
              style: context.textStyle.hint16,
            ),
            KSizedBox.kHeightSizedBox24,
            _button(context: context, isDesk: false),
          ];

Widget _button({
  required BuildContext context,
  required bool isDesk,
}) =>
    ButtonWidget(
      key: KWidgetkeys.screen.storyAdd.button,
      text: context.l10n.publish,
      isDesk: isDesk,
      onPressed: () =>
          context.read<StoryAddBloc>().add(const StoryAddEvent.save()),
    );
