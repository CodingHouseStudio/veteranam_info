import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class SignUpBodyWidget extends StatelessWidget {
  const SignUpBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, _) {
        return LeftCardWidget(
          key: KWidgetkeys.screen.signUp.card,
          widgetList: ({required isDesk}) => [
            Text(
              context.l10n.signUp,
              key: KWidgetkeys.screen.signUp.title,
              style: isDesk ? AppTextStyle.text96 : AppTextStyle.text32,
            ),
            EmailPasswordFieldsWidget(
              key: KWidgetkeys.screen.signUp.fields,
              isDesk: isDesk,
              showPassword: _.showPasswordField,
              onChangedEmail: (value) => context
                  .read<SignUpBloc>()
                  .add(SignUpEvent.emailUpdated(value)),
              onChangedPassword: (value) => context
                  .read<SignUpBloc>()
                  .add(SignUpEvent.passwordUpdated(value)),
              errorTextEmail: _.fieldsIsCorrect ?? true
                  ? null
                  : _.email.error.value(context),
              errorTextPassword: _.fieldsIsCorrect ?? true
                  ? null
                  : _.password.error.value(context),
              email: context.read<SignUpBloc>().state.email.value,
              backPassword: () => context.read<SignUpBloc>().add(
                    const SignUpEvent.passwordFieldHide(),
                  ),
            ),
            if (_.failure.getString(context) != null)
              Center(
                child: Text(
                  _.failure.getString(context)!,
                  key: KWidgetkeys.screen.signUp.failureMessage,
                  style: AppTextStyle.error14,
                ),
              ),
            if (isDesk)
              KSizedBox.kHeightSizedBox24
            else
              KSizedBox.kHeightSizedBox16,
            ButtonWidget(
              key: KWidgetkeys.screen.signUp.button,
              text: _.showPasswordField
                  ? context.l10n.register
                  : context.l10n.next,
              onPressed: () => context.read<SignUpBloc>().add(
                    const SignUpEvent.signUpSubmitted(),
                  ),
              isDesk: isDesk,
            ),
            KSizedBox.kHeightSizedBox40,
            Wrap(
              alignment: isDesk ? WrapAlignment.start : WrapAlignment.center,
              children: [
                Text(
                  context.l10n.doYouHavenAccount,
                  key: KWidgetkeys.screen.signUp.loginText,
                  style: isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
                ),
                TextButton(
                  key: KWidgetkeys.screen.signUp.loginButton,
                  onPressed: () => context.goNamedWithScroll(KRoute.login.name),
                  style:
                      KButtonStyles.transparentButtonStyleBottomBorder(context),
                  child: Text(
                    context.l10n.login,
                    style: isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
                  ),
                ),
              ],
            ),
            KSizedBox.kHeightSizedBox40,
            SignUpLoginBottomButtonsWidget(
              key: KWidgetkeys.screen.signUp.bottomButtons,
              isDesk: isDesk,
              title: context.l10n.signUpWith,
            ),
          ],
        );
      },
    );
  }
}
