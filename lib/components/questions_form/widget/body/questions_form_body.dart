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
    return ScaffoldDecorationWidget(
      mainChildWidgetsFunction: ({required isDesk}) => [
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
        ...List.generate(
          UserRole.values.length,
          (index) {
            final role = UserRole.values.elementAt(index);
            return Padding(
              padding: index != 0
                  ? EdgeInsets.only(
                      top: isDesk
                          ? KPadding.kPaddingSize32
                          : KPadding.kPaddingSize24,
                    )
                  : EdgeInsets.zero,
              child: CheckPointWidget(
                onChanged: role == userRole
                    ? null
                    : () => setState(() {
                          userRole = role;
                        }),
                text: role.value(context),
                isCheck: userRole == role,
                textStyle: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
                // key: KWidgetkeys.screen.questionsForm.roleVeteranText,
                key:
                    KWidgetkeys.screen.questionsForm.roleKeyes.elementAt(index),
                isDesk: isDesk,
              ),
            );
          },
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
