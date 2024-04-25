import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
              onChanged: () => setState(() {
                userRole = UserRole.veteran;
              }),
              isCheck: userRole == UserRole.veteran,
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
              onChanged: () => setState(() {
                userRole = UserRole.relativeOfVeteran;
              }),
              isCheck: userRole == UserRole.relativeOfVeteran,
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
              onChanged: () => setState(() {
                userRole = UserRole.civilian;
              }),
              isCheck: userRole == UserRole.civilian,
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
              onChanged: () => setState(() {
                userRole = UserRole.businessmen;
              }),
              isCheck: userRole == UserRole.businessmen,
            ),
            KSizedBox.kWidthSizedBox16,
            Text(
              context.l10n.iAmBusinessOwnerRepresentative,
              style: AppTextStyle.text24,
            ),
          ],
        ),
        KSizedBox.kHeightSizedBox40,
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) => state.userSetting.userRole != null
              ? context.goNamed(KRoute.home.name)
              : null,
          child: ButtonWidget(
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
