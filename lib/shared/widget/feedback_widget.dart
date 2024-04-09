import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class FeedbackWidget extends StatelessWidget {
  const FeedbackWidget({
    super.key,
    this.title,
    this.subtitle,
    this.messageHint,
  });
  final String? title;
  final String? subtitle;
  final String? messageHint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KSizedBox.kHeightSizedBox40,
        Text(
          title ?? context.l10n.feedback,
          key: KWidgetkeys.screen.investors.titile,
          style: AppTextStyle.text96,
        ),
        Text(
          subtitle ?? context.l10n.feedbackSubtitle,
          key: KWidgetkeys.screen.investors.subtitle,
          style: AppTextStyle.text24,
        ),
        KSizedBox.kHeightSizedBox56,
        Text(
          context.l10n.name,
          key: KWidgetkeys.screen.investors.name,
          style: AppTextStyle.text40,
        ),
        KSizedBox.kHeightSizedBox24,
        TextFieldWidget(
          widgetKey: KWidgetkeys.screen.investors.fieldName,
          onChanged: (value) {},
          hintText: context.l10n.text,
          contentPadding: const EdgeInsets.all(KPadding.kPaddingSize32),
        ),
        KSizedBox.kHeightSizedBox32,
        Text(
          '${context.l10n.email}*',
          key: KWidgetkeys.screen.investors.email,
          style: AppTextStyle.text40,
        ),
        KSizedBox.kHeightSizedBox24,
        TextFieldWidget(
          widgetKey: KWidgetkeys.screen.investors.fieldEmail,
          onChanged: (value) {},
          hintText: context.l10n.writeYourEmail,
          contentPadding: const EdgeInsets.all(KPadding.kPaddingSize32),
        ),
        KSizedBox.kHeightSizedBox32,
        Text(
          context.l10n.message,
          key: KWidgetkeys.screen.investors.message,
          style: AppTextStyle.text40,
        ),
        KSizedBox.kHeightSizedBox24,
        MessageFieldWidget(
          key: KWidgetkeys.screen.investors.fieldSuggestions,
          changeMessage: (String text) {},
          hintText: messageHint ?? context.l10n.writeYourMessage,
        ),
        KSizedBox.kHeightSizedBox24,
        ButtonWidget(
          key: KWidgetkeys.screen.investors.buttonSend,
          text: context.l10n.send,
          onPressed: () {},
        ),
        KSizedBox.kHeightSizedBox56,
      ],
    );
  }
}
