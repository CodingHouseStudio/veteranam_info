import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kozak/shared/shared.dart';

class QuestionsFormBody extends StatelessWidget {
  const QuestionsFormBody({super.key});

  @override
  Widget build(BuildContext context) {
    return LeftCardWidget(
      widgetList: ({required isDesk}) => [
        Text(
          context.l10n.fillInForm,
          style: AppTextStyle.text64,
        ),
        KSizedBox.kHeightSizedBox8,
        Text(
          context.l10n.questionsFormSubtitle,
          style: AppTextStyle.text24,
        ),
        KSizedBox.kHeightSizedBox56,
        Text(
          context.l10n.selectAppropriateOne,
          style: AppTextStyle.text40,
        ),
        KSizedBox.kHeightSizedBox40,
        Row(
          children: [
            CheckPointWidget(
              onChanged: ({required isCheck}) {},
            ),
            KSizedBox.kWidthSizedBox16,
            Text(
              context.l10n.iAmVeteran,
              style: AppTextStyle.text24,
            ),
          ],
        ),
        KSizedBox.kHeightSizedBox32,
        Row(
          children: [
            CheckPointWidget(
              onChanged: ({required isCheck}) {},
            ),
            KSizedBox.kWidthSizedBox16,
            Text(
              context.l10n.iAmRelativeOfVeteran,
              style: AppTextStyle.text24,
            ),
          ],
        ),
        KSizedBox.kHeightSizedBox32,
        Row(
          children: [
            CheckPointWidget(
              onChanged: ({required isCheck}) {},
            ),
            KSizedBox.kWidthSizedBox16,
            Text(
              context.l10n.iAmCivilian,
              style: AppTextStyle.text24,
            ),
          ],
        ),
        KSizedBox.kHeightSizedBox32,
        Row(
          children: [
            CheckPointWidget(
              onChanged: ({required isCheck}) {},
            ),
            KSizedBox.kWidthSizedBox16,
            Text(
              context.l10n.iAmBusinessOwnerRepresentative,
              style: AppTextStyle.text24,
            ),
          ],
        ),
        KSizedBox.kHeightSizedBox40,
        ButtonWidget(
          isDesk: isDesk,
          onPressed: () {},
          text: context.l10n.next,
        ),
      ],
    );
  }
}
