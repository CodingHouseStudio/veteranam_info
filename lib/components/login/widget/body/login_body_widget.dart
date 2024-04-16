import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class LoginBodyWidget extends StatelessWidget {
  const LoginBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesk =
            constraints.maxWidth > KPlatformConstants.minWidthThresholdTablet;
        return LeftCardWidget(
          key: KWidgetkeys.screen.login.card,
          isDesk: isDesk,
          childWidget: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, _) {
              return Column(
                crossAxisAlignment: isDesk
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                children: [
                  Text(
                    context.l10n.login,
                    key: KWidgetkeys.screen.login.title,
                    style: isDesk ? AppTextStyle.text96 : AppTextStyle.text32,
                  ),
                  EmailPasswordFieldsWidget(
                    key: KWidgetkeys.screen.login.fields,
                    isDesk: isDesk,
                    showPassword: _.showPassword,
                    onChangedEmail: (value) => context
                        .read<LoginBloc>()
                        .add(LoginEvent.emailUpdated(value)),
                    onChangedPassword: (value) => context
                        .read<LoginBloc>()
                        .add(LoginEvent.passwordUpdated(value)),
                    errorTextEmail: _.fieldsState == FieldEnum.invalidData
                        ? _.email.error.value(context)
                        : null,
                    errorTextPassword: _.fieldsState == FieldEnum.invalidData
                        ? _.password.error.value(context)
                        : null,
                    email: context.read<LoginBloc>().state.email.value,
                    backPassword: () => context.read<SignUpBloc>().add(
                          const SignUpEvent.passwordHide(),
                        ),
                  ),
                  if (isDesk)
                    KSizedBox.kHeightSizedBox24
                  else
                    KSizedBox.kHeightSizedBox16,
                  ButtonWidget(
                    key: KWidgetkeys.screen.login.button,
                    text: context.l10n.login,
                    onPressed: () => context.read<LoginBloc>().add(
                          const LoginEvent.loginSubmitted(),
                        ),
                    isDesk: isDesk,
                  ),
                  KSizedBox.kHeightSizedBox40,
                  Wrap(
                    alignment:
                        isDesk ? WrapAlignment.start : WrapAlignment.center,
                    children: [
                      Text(
                        context.l10n.donotYouHavenAccount,
                        key: KWidgetkeys.screen.login.signUpText,
                        style:
                            isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
                      ),
                      TextButton(
                        key: KWidgetkeys.screen.login.signUpButton,
                        onPressed: () => context.go(KRoute.signUp.path),
                        style: KButtonStyles.transparentButtonStyleBottomBorder,
                        child: Text(
                          context.l10n.register,
                          style: isDesk
                              ? AppTextStyle.text40
                              : AppTextStyle.text24,
                        ),
                      ),
                    ],
                  ),
                  KSizedBox.kHeightSizedBox40,
                  SignUpBottomButtonsWidget(
                    key: KWidgetkeys.screen.login.bottomButtons,
                    isDesk: isDesk,
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
