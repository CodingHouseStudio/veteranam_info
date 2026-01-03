import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/questions_form/bloc/user_role_bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class QuestionsFormBody extends StatefulWidget {
  const QuestionsFormBody({super.key});

  @override
  State<QuestionsFormBody> createState() => _QuestionsFormBodyState();
}

class _QuestionsFormBodyState extends State<QuestionsFormBody> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserRoleBloc, UserRoleState>(
      listener: (context, state) => state.formState == UserRoleEnum.success
          ? context.goNamed(KRoute.thanks.name)
          : null,
      builder: (context, state) {
        return ScaffoldDecorationWidget(
          mainChildWidgetsFunction: ({required isDesk}) => [
            Text(
              context.l10n.fillInForm,
              key: QuestionsFormKeys.title,
              style: isDesk ? AppTextStyle.text64 : AppTextStyle.text32,
            ),
            KSizedBox.kHeightSizedBox8,
            Text(
              context.l10n.questionsFormSubtitle,
              key: QuestionsFormKeys.subtitle,
              style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
            ),
            KSizedBox.kHeightSizedBox56,
            Text(
              context.l10n.selectAppropriateOne,
              key: QuestionsFormKeys.roleTitle,
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
                    onChanged: role == state.userRole
                        ? null
                        : () => context
                            .read<UserRoleBloc>()
                            .add(UserRoleEvent.changeUserRole(role)),
                    text: role.value(context),
                    isCheck: state.userRole == role,
                    textStyle:
                        isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
                    // key: QuestionsFormKeys.roleVeteranText,
                    key: QuestionsFormKeys.roleKeyes.elementAt(index),
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
                key: QuestionsFormKeys.button,
                isDesk: isDesk,
                onPressed: () => context
                    .read<UserRoleBloc>()
                    .add(const UserRoleEvent.send()),
                text: context.l10n.next,
              ),
            ),
          ],
        );
      },
    );
  }
}
