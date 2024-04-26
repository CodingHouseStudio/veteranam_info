import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      widgetList: ({required isDesk}) => [
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
        Row(
          children: [
            CheckPointWidget(
              key: KWidgetkeys.screen.questionsForm.roleVeteran,
              onChanged: () => setState(() {
                userRole = UserRole.veteran;
              }),
              isCheck: userRole == UserRole.veteran,
            ),
            KSizedBox.kWidthSizedBox16,
            Expanded(
              child: Text(
                context.l10n.iAmVeteran,
                key: KWidgetkeys.screen.questionsForm.roleVeteranText,
                style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
              ),
            ),
          ],
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox32
        else
          KSizedBox.kHeightSizedBox24,
        Row(
          children: [
            CheckPointWidget(
              key: KWidgetkeys.screen.questionsForm.roleRelativeOfVeteran,
              onChanged: () => setState(() {
                userRole = UserRole.relativeOfVeteran;
              }),
              isCheck: userRole == UserRole.relativeOfVeteran,
            ),
            KSizedBox.kWidthSizedBox16,
            Expanded(
              child: Text(
                context.l10n.iAmRelativeOfVeteran,
                key: KWidgetkeys.screen.questionsForm.roleRelativeOfVeteranText,
                style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
              ),
            ),
          ],
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox32
        else
          KSizedBox.kHeightSizedBox24,
        Row(
          children: [
            CheckPointWidget(
              key: KWidgetkeys.screen.questionsForm.roleCivilian,
              onChanged: () => setState(() {
                userRole = UserRole.civilian;
              }),
              isCheck: userRole == UserRole.civilian,
            ),
            KSizedBox.kWidthSizedBox16,
            Expanded(
              child: Text(
                context.l10n.iAmCivilian,
                key: KWidgetkeys.screen.questionsForm.roleCivilianText,
                style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
              ),
            ),
          ],
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox32
        else
          KSizedBox.kHeightSizedBox24,
        Row(
          children: [
            CheckPointWidget(
              key: KWidgetkeys.screen.questionsForm.roleBusinessmen,
              onChanged: () => setState(() {
                userRole = UserRole.businessmen;
              }),
              isCheck: userRole == UserRole.businessmen,
            ),
            KSizedBox.kWidthSizedBox16,
            Expanded(
              child: Text(
                context.l10n.iAmBusinessOwnerRepresentative,
                key: KWidgetkeys.screen.questionsForm.roleBusinessmenText,
                style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
              ),
            ),
          ],
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox40
        else
          KSizedBox.kHeightSizedBox32,
        ButtonWidget(
          key: KWidgetkeys.screen.questionsForm.button,
          isDesk: isDesk,
          onPressed: userRole != null
              ? () => context
                  .read<AuthenticationBloc>()
                  .add(AppUserRoleChanged(userRole!))
              : null,
          text: context.l10n.next,
        ),
      ],
    );
  }
}
