part of 'body/feedback_body_widget.dart';

List<Widget> _titleWidgetList({
  required bool isDesk,
  required BuildContext context,
}) =>
    isDesk
        ? [
            KSizedBox.kHeightSizedBox48,
            ...TitleWidget.pointTitleWidgetList(
              isDesk: isDesk,
              pointText: context.l10n.feedback,
              pointKey: KWidgetkeys.screen.feedback.pointText,
              title: context.l10n.write,
              titleSecondPart: '${context.l10n.us} ${context.l10n.aMessage}',
              titleKey: KWidgetkeys.screen.feedback.title,
            ),
            KSizedBox.kHeightSizedBox100,
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
                  context.l10n.aMessage,
                  style: AppTextStyle.materialThemeDisplaySmall,
                ),
              ],
            ),
            KSizedBox.kHeightSizedBox32,
            Divider(
              key: KWidgetkeys.screen.feedback.divider,
              color: AppColors.materialThemeKeyColorsNeutral,
            ),
            KSizedBox.kHeightSizedBox24,
          ];
