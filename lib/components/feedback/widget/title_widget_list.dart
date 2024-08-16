part of 'body/feedback_body_widget.dart';

List<Widget> _titleWidgetList({
  required bool isDesk,
  required BuildContext context,
  required String title,
  required String? titleSecondPart,
  required String? text,
  required String secondText,
}) =>
    isDesk
        ? [
            KSizedBox.kHeightSizedBox24,
            if (titleSecondPart != null)
              ...TitleWidget.pointTitleWidgetList(
                isDesk: true,
                //pointText: context.l10n.feedback,
                // pointKey: KWidgetkeys.screen.feedback.pointText,
                title: title,
                titleSecondPart: titleSecondPart,
                titleKey: KWidgetkeys.screen.feedback.title,
              )
            else
              ...TitleWidget.oneTitleIconWidgetList(
                title: title,
                titleKey: KWidgetkeys.screen.feedback.title,
                isDesk: isDesk,
              ),
            KSizedBox.kHeightSizedBox100,
          ]
        : [
            // KSizedBox.kHeightSizedBox24,
            // TextPointWidget(
            //   context.l10n.feedback,
            //   key: KWidgetkeys.screen.feedback.pointText,
            // ),
            KSizedBox.kHeightSizedBox16,
            if (text != null)
              Text(
                text,
                style: AppTextStyle.materialThemeDisplaySmall,
              ),
            Row(
              key: KWidgetkeys.screen.feedback.title,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const IconWidget(
                  icon: KIcon.arrowDownRight,
                  padding: KPadding.kPaddingSize12,
                ),
                KSizedBox.kWidthSizedBox16,
                Expanded(
                  child: Text(
                    secondText,
                    style: AppTextStyle.materialThemeDisplaySmall,
                  ),
                ),
              ],
            ),
            KSizedBox.kHeightSizedBox32,
            const Divider(
              color: AppColors.materialThemeKeyColorsNeutral,
            ),
            KSizedBox.kHeightSizedBox24,
          ];
