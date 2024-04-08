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
          style: AppTextStyle.text96,
        ),
        Text(
          context.l10n.investorsSubtitle,
          style: AppTextStyle.text24,
        ),
        KSizedBox.kHeightSizedBox56,
        Text(
          context.l10n.name,
          style: AppTextStyle.text40,
        ),
        KSizedBox.kHeightSizedBox24,
        TextFieldWidget(
          widgetKey: const Key(''),
          onChanged: (value) {},
          hintText: context.l10n.text,
          contentPadding: const EdgeInsets.all(KPadding.kPaddingSize32),
        ),
        KSizedBox.kHeightSizedBox32,
        Text(
          '${context.l10n.email}*',
          style: AppTextStyle.text40,
        ),
        KSizedBox.kHeightSizedBox24,
        TextFieldWidget(
          widgetKey: const Key(''),
          onChanged: (value) {},
          hintText: context.l10n.writeYourEmail,
          contentPadding: const EdgeInsets.all(KPadding.kPaddingSize32),
        ),
        KSizedBox.kHeightSizedBox32,
        Text(
          context.l10n.message,
          style: AppTextStyle.text40,
        ),
        KSizedBox.kHeightSizedBox24,
        MessageFieldWidget(
          changeMessage: (String text) {},
          hintText: context.l10n.writeYourSuggenstions,
        ),
        KSizedBox.kHeightSizedBox24,
        ButtonWidget(
          text: context.l10n.send,
          onPressed: () {},
        ),
        KSizedBox.kHeightSizedBox56,
      ],
    );
  }
}
