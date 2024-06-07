part of 'body/feedback_body_widget.dart';

List<Widget> _titleWidgetList({
  required bool isDesk,
  required BuildContext context,
}) =>
    isDesk
        ? [
            KSizedBox.kHeightSizedBox48,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextPointWidget(
                    context.l10n.feedback,
                    key: KWidgetkeys.screen.feedback.pointText,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    key: KWidgetkeys.screen.feedback.title,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        context.l10n.write,
                        style: AppTextStyle.materialThemeDisplayLarge,
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.end,
                        children: [
                          Text(
                            '${context.l10n.us} ${context.l10n.message}',
                            style: AppTextStyle.materialThemeDisplayLarge,
                          ),
                          KSizedBox.kWidthSizedBox24,
                          IconWidget(
                            icon: KIcon.arrowDownRight.copyWith(
                              key: KWidgetkeys.screen.feedback.titleIcon,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            KSizedBox.kHeightSizedBox132,
          ]
        : [
            KSizedBox.kHeightSizedBox24,
            TextPointWidget(
              context.l10n.feedback,
              key: KWidgetkeys.screen.feedback.pointText,
            ),
            KSizedBox.kHeightSizedBox16,
            Text(
              '${context.l10n.write} ${context.l10n.us}',
              style: AppTextStyle.materialThemeDisplaySmall,
            ),
            Wrap(
              key: KWidgetkeys.screen.feedback.title,
              crossAxisAlignment: WrapCrossAlignment.end,
              children: [
                IconWidget(
                  icon: KIcon.arrowDownRight.copyWith(
                    key: KWidgetkeys.screen.feedback.titleIcon,
                  ),
                  padding: KPadding.kPaddingSize12,
                ),
                KSizedBox.kWidthSizedBox16,
                Text(
                  context.l10n.message,
                  style: AppTextStyle.materialThemeDisplaySmall,
                ),
              ],
            ),
            KSizedBox.kHeightSizedBox56,
          ];
