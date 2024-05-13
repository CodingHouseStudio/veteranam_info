import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class QuestionsFormBody extends StatefulWidget {
  const QuestionsFormBody({super.key});

  @override
  State<QuestionsFormBody> createState() => _QuestionsFormBodyState();
}

class _QuestionsFormBodyState extends State<QuestionsFormBody> {
  late UserRole? userRole;
  @override
  void initState() {
    userRole = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LeftCardWidget(
      widgetListFunction: ({required isDesk}) => [
        Text(
          context.l10n.fillInForm,
          key: KWidgetkeys.screen.questionsForm.title,
          style: isDesk ? AppTextStyle.text64 : AppTextStyle.text32,
        ),
        KSizedBox.kHeightSizedBox8,
        Text(
          context.l10n.questionsFormSubtitle,
          key: KWidgetkeys.screen.questionsForm.subtitle,
          style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
        ),
        KSizedBox.kHeightSizedBox56,
        Text(
          context.l10n.selectAppropriateOne,
          key: KWidgetkeys.screen.questionsForm.roleTitle,
          style: isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox40
        else
          KSizedBox.kHeightSizedBox32,
        AnswerWidget(
          onChanged: () => setState(() {
            userRole = UserRole.veteran;
          }),
          text: context.l10n.iAmVeteran,
          isDesk: isDesk,
          isCheck: userRole == UserRole.veteran,
          textKey: KWidgetkeys.screen.questionsForm.roleVeteranText,
          checkPointKey: KWidgetkeys.screen.questionsForm.roleVeteran,
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox32
        else
          KSizedBox.kHeightSizedBox24,
        AnswerWidget(
          onChanged: () => setState(() {
            userRole = UserRole.relativeOfVeteran;
          }),
          text: context.l10n.iAmRelativeOfVeteran,
          isDesk: isDesk,
          isCheck: userRole == UserRole.relativeOfVeteran,
          textKey: KWidgetkeys.screen.questionsForm.roleRelativeOfVeteranText,
          checkPointKey: KWidgetkeys.screen.questionsForm.roleRelativeOfVeteran,
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox32
        else
          KSizedBox.kHeightSizedBox24,
        AnswerWidget(
          onChanged: () => setState(() {
            userRole = UserRole.civilian;
          }),
          text: context.l10n.iAmCivilian,
          isDesk: isDesk,
          isCheck: userRole == UserRole.civilian,
          textKey: KWidgetkeys.screen.questionsForm.roleCivilianText,
          checkPointKey: KWidgetkeys.screen.questionsForm.roleCivilian,
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox32
        else
          KSizedBox.kHeightSizedBox24,
        AnswerWidget(
          onChanged: () => setState(() {
            userRole = UserRole.businessmen;
          }),
          text: context.l10n.iAmBusinessOwnerRepresentative,
          isDesk: isDesk,
          isCheck: userRole == UserRole.businessmen,
          textKey: KWidgetkeys.screen.questionsForm.roleBusinessmenText,
          checkPointKey: KWidgetkeys.screen.questionsForm.roleBusinessmen,
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox40
        else
          KSizedBox.kHeightSizedBox32,
        Align(
          alignment: Alignment.centerLeft,
          child: ButtonWidget(
            key: KWidgetkeys.screen.questionsForm.button,
            isDesk: isDesk,
            onPressed: userRole != null
                ? () => context
                    .read<AuthenticationBloc>()
                    .add(AppUserRoleChanged(userRole!))
                : null,
            text: context.l10n.next,
          ),
        ),
      ],
    );
  }
}
