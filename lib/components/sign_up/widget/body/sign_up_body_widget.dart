import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class SignUpBodyWidget extends StatelessWidget {
  const SignUpBodyWidget({required this.isDesk, super.key});
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) => state.failure == SignUpError.none
          ? context.goNamed(KRoute.home.name)
          : null,
      builder: (context, _) {
        return LeftCardWidget(
          key: KWidgetkeys.screen.signUp.card,
          isDesk: isDesk,
          widgetList: [
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
            if (isDesk)
              KSizedBox.kHeightSizedBox24
            else
              KSizedBox.kHeightSizedBox16,
            ButtonWidget(
              key: KWidgetkeys.screen.signUp.button,
              text: context.l10n.register,
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
                  onPressed: () => context.goNamed(KRoute.login.name),
                  style: KButtonStyles.transparentButtonStyleBottomBorder,
                  child: Text(
                    context.l10n.login,
                    style: isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
                  ),
                ),
              ],
            ),
            KSizedBox.kHeightSizedBox40,
            SignUpBottomButtonsWidget(
              key: KWidgetkeys.screen.signUp.bottomButtons,
              isDesk: isDesk,
            ),
          ],
        );
      },
    );
  }
}
