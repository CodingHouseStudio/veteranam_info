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
          mainDecoration: KWidgetTheme.boxDecorationWidget,
          mainPadding: ({required isDesk, required maxWidth}) =>
              EdgeInsets.symmetric(
            horizontal: isDesk ? maxWidth * 0.2 : 0,
            vertical:
                isDesk ? KPadding.kPaddingSize80 : KPadding.kPaddingSize24,
          ),
          // mainDecorationPadding: ({required isDesk}) => EdgeInsets.all(
          //   isDesk ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16,
          // ),
          mainChildWidgetsFunction: ({required isDesk}) => [
            Row(
              children: [
                Text(
                  context.l10n.login,
                  key: KWidgetkeys.screen.login.title,
                  style: isDesk
                      ? AppTextStyle.materialThemeDisplayLarge
                      : AppTextStyle.text32,
                ),
                KSizedBox.kWidthSizedBox32,
                IconWidget(
                  icon: KIcon.arrowDownRight,
                  padding:
                      isDesk ? KPadding.kPaddingSize20 : KPadding.kPaddingSize8,
                ),
              ],
            ),
            KSizedBox.kHeightSizedBox40,
            Padding(
              padding: const EdgeInsets.only(right: 75),
              child: Column(
                children: [
                  EmailPasswordFieldsWidget(
                    key: KWidgetkeys.screen.login.fields,
                    isDesk: isDesk,
                    showPassword: _.showPasswordField,
                    onChangedEmail: (value) => context
                        .read<LoginBloc>()
                        .add(LoginEvent.emailUpdated(value)),
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
                      color: AppColors.materialThemeBlack,
                      textColor: AppColors.materialThemeWhite,
                      mobHorizontalTextPadding: KPadding.kPaddingSize60,
                      mobVerticalTextPadding: KPadding.kPaddingSize12,
                      mobIconPadding: KPadding.kPaddingSize12,
                    ),
                  ),
                  KSizedBox.kHeightSizedBox24,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: KPadding.kPaddingSize16,
                    ),
                    child: Row(
                      children: [
                        Text(
                          context.l10n.donotYouHavenAccount,
                          key: KWidgetkeys.screen.login.signUpText,
                          style: isDesk
                              ? AppTextStyle.materialThemeTitleMedium
                              : AppTextStyle.text24,
                        ),
                        KSizedBox.kWidthSizedBox16,
                        TextButton(
                          key: KWidgetkeys.screen.login.signUpButton,
                          onPressed: () => context.goNamed(KRoute.signUp.name),
                          style: KButtonStyles.borderBlackButtonStyle,
                          child: Text(
                            context.l10n.register,
                            style: isDesk
                                ? AppTextStyle.materialThemeTitleMedium
                                : AppTextStyle.text24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  KSizedBox.kHeightSizedBox40,
                  const Divider(
                    color: AppColors.materialThemeBlack,
                    height: KSize.kPixel1,
                    thickness: KSize.kPixel1,
                  ),
                  KSizedBox.kHeightSizedBox40,
                  Row(
                    children: [
                      Container(
                        width: KSize.kRadius8,
                        height: KSize.kRadius8,
                        decoration: const BoxDecoration(
                          color: AppColors
                              .materialThemeKeyColorsPrimary, // The yellow-green color of the circle
                          shape: BoxShape.circle,
                        ),
                      ),
                      KSizedBox.kWidthSizedBox8,
                      Text(
                        //key: ,
                        context.l10n.logInWith,
                      ),
                    ],
                  ),
                  KSizedBox.kHeightSizedBox16,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ButtonAdditionalWidget(
                      isDesk: isDesk,
                      key: KWidgetkeys.widget.signUpBottomButtons.google,
                      text: context.l10n.google,
                      picture: KImage.google(),
                      onPressed: () => context
                          .read<AuthenticationServicesCubit>()
                          .authenticationUseGoogle(),
                    ),
                  ),
                ],
              ),
            ),

            // KSizedBox.kHeightSizedBox40,
            // SignUpLoginBottomButtonsWidget(
            //   key: KWidgetkeys.screen.login.bottomButtons,
            //   isDesk: isDesk,
            //   title: context.l10n.logInWith,
            // ),
          ],
        );
      },
    );
  }
}
