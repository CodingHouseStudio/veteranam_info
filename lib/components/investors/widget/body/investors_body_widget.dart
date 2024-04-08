import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kozak/shared/shared.dart';

class InvestorsBodyWidget extends StatelessWidget {
  const InvestorsBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KSizedBox.kHeightSizedBox40,
        Text(
          context.l10n.investors,
          key: KWidgetkeys.screen.investors.titile,
          style: AppTextStyle.text96,
        ),
        Text(
          context.l10n.investorsSubtitle,
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
          hintText: context.l10n.writeYourSuggenstions,
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
