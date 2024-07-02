import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/shared/shared.dart';

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
        CheckPointWidget(
          onChanged: () => setState(() {
            userRole = UserRole.veteran;
          }),
          text: context.l10n.iAmVeteran,
          isCheck: userRole == UserRole.veteran,
          textStyle: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
          // key: KWidgetkeys.screen.questionsForm.roleVeteranText,
          key: KWidgetkeys.screen.questionsForm.roleVeteran, isDesk: isDesk,
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox32
        else
          KSizedBox.kHeightSizedBox24,
        CheckPointWidget(
          onChanged: () => setState(() {
            userRole = UserRole.relativeOfVeteran;
          }),
          text: context.l10n.iAmRelativeOfVeteran,
          isCheck: userRole == UserRole.relativeOfVeteran,
          textStyle: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
          // textKey: KWidgetkeys.screen.questionsForm
          // .roleRelativeOfVeteranText,
          key: KWidgetkeys.screen.questionsForm.roleRelativeOfVeteran,
          isDesk: isDesk,
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox32
        else
          KSizedBox.kHeightSizedBox24,
        CheckPointWidget(
          onChanged: () => setState(() {
            userRole = UserRole.civilian;
          }),
          text: context.l10n.iAmCivilian,
          isCheck: userRole == UserRole.civilian,
          textStyle: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
          // textKey: KWidgetkeys.screen.questionsForm.roleCivilianText,
          key: KWidgetkeys.screen.questionsForm.roleCivilian, isDesk: isDesk,
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox32
        else
          KSizedBox.kHeightSizedBox24,
        CheckPointWidget(
          onChanged: () => setState(() {
            userRole = UserRole.businessmen;
          }),
          text: context.l10n.iAmBusinessOwnerRepresentative,
          isCheck: userRole == UserRole.businessmen,
          textStyle: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
          // textKey: KWidgetkeys.screen.questionsForm.roleBusinessmenText,
          key: KWidgetkeys.screen.questionsForm.roleBusinessmen, isDesk: isDesk,
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
