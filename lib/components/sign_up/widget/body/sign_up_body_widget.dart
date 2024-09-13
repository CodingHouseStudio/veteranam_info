import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

class SignUpBodyWidget extends StatelessWidget {
  const SignUpBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) => context.dialog.showSnackBardTextDialog(
        state.failure?.value(context),
      ),
      builder: (context, _) {
        return ScaffoldDecorationWidget(
          key: KWidgetkeys.screen.signUp.card,
          mainPadding: ({required isDesk, required maxWidth}) =>
              EdgeInsets.symmetric(
            horizontal: maxWidth > KMinMaxSize.maxWidth640 ? maxWidth * 0.2 : 0,
            vertical:
                isDesk ? KPadding.kPaddingSize80 : KPadding.kPaddingSize24,
          ),
          mainChildWidgetsFunction: ({required isDesk}) => [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    context.l10n.signUp,
                    key: KWidgetkeys.screen.signUp.title,
                    style: isDesk
                        ? AppTextStyle.materialThemeDisplayLarge
                        : AppTextStyle.materialThemeDisplaySmall,
                  ),
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
              isLogin: false,
            ),
            if (isDesk)
              KSizedBox.kHeightSizedBox24
            else
              KSizedBox.kHeightSizedBox16,
            Align(
              alignment: Alignment.centerLeft,
              child: DoubleButtonWidget(
                widgetKey: KWidgetkeys.screen.signUp.button,
                text: _.showPasswordField
                    ? context.l10n.register
                    : context.l10n.next,
                onPressed: () => context.read<SignUpBloc>().add(
                      const SignUpEvent.signUpSubmitted(),
                    ),
                isDesk: isDesk,
                color: AppColors.materialThemeKeyColorsSecondary,
                textColor: AppColors.materialThemeWhite,
                deskPadding: const EdgeInsets.symmetric(
                  horizontal: KPadding.kPaddingSize64,
                  vertical: KPadding.kPaddingSize12,
                ),
                mobTextWidth: double.infinity,
                mobHorizontalTextPadding: KPadding.kPaddingSize60,
                mobVerticalTextPadding: KPadding.kPaddingSize12,
                mobIconPadding: KPadding.kPaddingSize12,
                darkMode: true,
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
                    context.l10n.doYouHavenAccount,
                    key: KWidgetkeys.screen.signUp.loginText,
                    style: AppTextStyle.materialThemeTitleMedium,
                  ),
                  KSizedBox.kWidthSizedBox16,
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        key: KWidgetkeys.screen.signUp.loginButton,
                        onPressed: () => context.goNamed(KRoute.login.name),
                        style: KButtonStyles.borderBlackButtonStyle,
                        child: Text(
                          context.l10n.login,
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
              context.l10n.signUpInWith,
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
