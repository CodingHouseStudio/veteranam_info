import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

class LoginBodyWidget extends StatelessWidget {
  const LoginBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) => context.dialog.showSnackBardTextDialog(
        state.failure?.value(context),
      ),
      builder: (context, _) {
        return ScaffoldDecorationWidget(
          key: KWidgetkeys.screen.login.card,
          mainChildWidgetsFunction: ({required isDesk}) => [
            Align(
              alignment: isDesk ? Alignment.centerLeft : Alignment.center,
              child: Text(
                context.l10n.login,
                key: KWidgetkeys.screen.login.title,
                style: isDesk ? AppTextStyle.text96 : AppTextStyle.text32,
              ),
            ),
            EmailPasswordFieldsWidget(
              key: KWidgetkeys.screen.login.fields,
              isDesk: isDesk,
              showPassword: _.showPasswordField,
              onChangedEmail: (value) =>
                  context.read<LoginBloc>().add(LoginEvent.emailUpdated(value)),
              onChangedPassword: (value) => context
                  .read<LoginBloc>()
                  .add(LoginEvent.passwordUpdated(value)),
              errorTextEmail: _.fieldsIsCorrect ?? true
                  ? null
                  : _.email.error.value(context),
              errorTextPassword: _.fieldsIsCorrect ?? true
                  ? null
                  : _.password.error.value(context),
              email: context.read<LoginBloc>().state.email.value,
              backPassword: () => context.read<LoginBloc>().add(
                    const LoginEvent.passwordFieldHide(),
                  ),
            ),
            if (isDesk)
              KSizedBox.kHeightSizedBox24
            else
              KSizedBox.kHeightSizedBox16,
            Align(
              alignment: Alignment.centerLeft,
              child: ButtonWidget(
                key: KWidgetkeys.screen.login.button,
                text: _.showPasswordField
                    ? context.l10n.login
                    : context.l10n.next,
                onPressed: () => context.read<LoginBloc>().add(
                      const LoginEvent.loginSubmitted(),
                    ),
                isDesk: isDesk,
              ),
            ),
            KSizedBox.kHeightSizedBox40,
            Wrap(
              alignment: isDesk ? WrapAlignment.start : WrapAlignment.center,
              children: [
                Text(
                  context.l10n.donotYouHavenAccount,
                  key: KWidgetkeys.screen.login.signUpText,
                  style: isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
                ),
                TextButton(
                  key: KWidgetkeys.screen.login.signUpButton,
                  onPressed: () => context.goNamed(KRoute.signUp.name),
                  style: KButtonStyles.transparentButtonStyleBottomBorder,
                  child: Text(
                    context.l10n.register,
                    style: isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
                  ),
                ),
              ],
            ),
            KSizedBox.kHeightSizedBox40,
            SignUpLoginBottomButtonsWidget(
              key: KWidgetkeys.screen.login.bottomButtons,
              isDesk: isDesk,
              title: context.l10n.logInWith,
            ),
          ],
        );
      },
    );
  }
}
