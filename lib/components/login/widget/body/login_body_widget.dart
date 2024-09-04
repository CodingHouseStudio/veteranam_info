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
          mainPadding: ({required isDesk, required maxWidth}) =>
              EdgeInsets.symmetric(
            horizontal: maxWidth > KMinMaxSize.maxWidth640 ? maxWidth * 0.2 : 0,
            vertical:
                isDesk ? KPadding.kPaddingSize80 : KPadding.kPaddingSize24,
          ),
          mainChildWidgetsFunction: ({required isDesk}) => [
            Row(
              children: [
                Text(
                  context.l10n.login,
                  key: KWidgetkeys.screen.login.title,
                  style: isDesk
                      ? AppTextStyle.materialThemeDisplayLarge
                      : AppTextStyle.materialThemeDisplaySmall,
                ),
                if (isDesk)
                  KSizedBox.kWidthSizedBox32
                else
                  KSizedBox.kWidthSizedBox24,
                IconWidget(
                  icon: KIcon.arrowDownLeft,
                  padding:
                      isDesk ? KPadding.kPaddingSize20 : KPadding.kPaddingSize8,
                ),
              ],
            ),
            if (isDesk)
              KSizedBox.kHeightSizedBox40
            else
              KSizedBox.kHeightSizedBox24,
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
              child: DoubleButtonWidget(
                widgetKey: KWidgetkeys.screen.login.button,
                text: _.showPasswordField
                    ? context.l10n.login
                    : context.l10n.next,
                onPressed: () => context.read<LoginBloc>().add(
                      const LoginEvent.loginSubmitted(),
                    ),
                isDesk: false,
                color: AppColors.materialThemeKeyColorsSecondary,
                textColor: AppColors.materialThemeWhite,
                mobTextWidth: isDesk ? null : double.infinity,
                mobHorizontalTextPadding: KPadding.kPaddingSize60,
                mobVerticalTextPadding: KPadding.kPaddingSize12,
                mobIconPadding: KPadding.kPaddingSize12,
              ),
            ),
            if (isDesk)
              KSizedBox.kHeightSizedBox24
            else
              KSizedBox.kHeightSizedBox16,
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: KPadding.kPaddingSize16,
              ),
              child: Row(
                children: [
                  Text(
                    context.l10n.donotYouHavenAccount,
                    key: KWidgetkeys.screen.login.signUpText,
                    style: AppTextStyle.materialThemeTitleMedium,
                  ),
                  KSizedBox.kWidthSizedBox16,
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        key: KWidgetkeys.screen.login.signUpButton,
                        onPressed: () => context.goNamed(KRoute.signUp.name),
                        style: KButtonStyles.borderBlackButtonStyle,
                        child: Text(
                          context.l10n.signUp,
                          style: isDesk
                              ? AppTextStyle.materialThemeTitleMedium
                              : AppTextStyle.materialThemeTitleSmall,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            KSizedBox.kHeightSizedBox40,
            const Divider(
              color: AppColors.materialThemeKeyColorsNeutral,
              height: KSize.kPixel1,
              thickness: KSize.kPixel1,
            ),
            if (isDesk)
              KSizedBox.kHeightSizedBox40
            else
              KSizedBox.kHeightSizedBox24,
            TextPointWidget(
              //key: ,
              context.l10n.logInWith,
              pointColor: AppColors.materialThemeKeyColorsPrimary,
              textStyle: AppTextStyle.materialThemeTitleMedium,
              mainAxisAlignment: MainAxisAlignment.start,
            ),
            KSizedBox.kHeightSizedBox16,
            Align(
              alignment: Alignment.centerLeft,
              child: ButtonAdditionalWidget(
                key: KWidgetkeys.widget.signUpBottomButtons.google,
                text: context.l10n.google,
                picture: KImage.google(),
                onPressed: () => context
                    .read<AuthenticationServicesCubit>()
                    .authenticationUseGoogle(),
                isDesk: isDesk,
              ),
            ),
          ],
        );
      },
    );
  }
}
