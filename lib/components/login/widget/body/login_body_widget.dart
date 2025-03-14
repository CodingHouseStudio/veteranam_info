import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/login/bloc/login_bloc.dart';
import 'package:veteranam/components/login/login.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class LoginBodyWidget extends StatelessWidget {
  const LoginBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginBlocListener(
      child: BlocBuilder<LoginBloc, LoginState>(
        // listener: (context, state) => context.dialog.showSnackBardTextDialog(
        //   state.failure?.value(context),
        // ),
        builder: (context, _) {
          return ScaffoldWidget(
            key: LoginKeys.card,
            mainDeskPadding: ({required maxWidth}) => maxWidth.screenPadding(
              precent: KDimensions.thirtyPercent,
              verticalPadding: KPadding.kPaddingSize80,
              notUseHorizontal: maxWidth > KMinMaxSize.maxWidth640,
            ),
            isForm: true,
            pageName: context.l10n.login,
            showMobBottomNavigation: true,
            bottomBarIndex: 3,
            showAppBar: Config.isWeb,
            mainChildWidgetsFunction: ({required isDesk, required isTablet}) =>
                [
              if (!isDesk) KSizedBox.kHeightSizedBox24,
              ShortTitleIconWidget(
                title: context.l10n.login,
                titleKey: LoginKeys.title,
                isDesk: isDesk,
              ),
              if (isDesk)
                KSizedBox.kHeightSizedBox40
              else
                KSizedBox.kHeightSizedBox24,
              EmailPasswordFieldsWidget(
                key: LoginKeys.fields,
                isDesk: isDesk,
                showPassword: showPassword(_.formState),
                onChangedEmail: (value) => context
                    .read<LoginBloc>()
                    .add(LoginEvent.emailUpdated(value)),
                onChangedPassword: (value) => context
                    .read<LoginBloc>()
                    .add(LoginEvent.passwordUpdated(value)),
                errorTextEmail: _.email.error.value(context),
                errorTextPassword: _.password.error.value(context),
                email: context.read<LoginBloc>().state.email.value,
                backPassword: () => context.read<LoginBloc>().add(
                      const LoginEvent.passwordFieldHide(),
                    ),
                showErrorText: _.formState == LoginEnum.invalidData ||
                    _.formState == LoginEnum.passwordInvalidData,
                isLogin: true,
                // bottomError: _.failure?.value(context),
              ),
              if (isDesk)
                KSizedBox.kHeightSizedBox24
              else
                KSizedBox.kHeightSizedBox16,
              DoubleButtonWidget(
                widgetKey: LoginKeys.button,
                text: showPassword(_.formState)
                    ? context.l10n.login
                    : context.l10n.next,
                onPressed: () => context.read<LoginBloc>().add(
                      const LoginEvent.loginSubmitted(),
                    ),
                isDesk: isDesk,
                // color: AppColors.materialThemeKeyColorsSecondary,
                // textColor: AppColors.materialThemeWhite,
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
              SendingTextWidget(
                textKey: LoginKeys.submitingText,
                failureText: _.failure?.value(context),
                sendingText: context.l10n.loggingInWait,
                successText: null,
                showSendingText: _.formState == LoginEnum.success,
              ),
              // if (_.formState == LoginEnum.success) ...[
              //   KSizedBox.kHeightSizedBox16,
              //   Padding(
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: KPadding.kPaddingSize16,
              //     ),
              //     child: Text(
              //       context.l10n.loggingInWait,
              //       key: LoginKeys.loadingText,
              //       style:
              // AppTextStyle.materialThemeBodyMediumNeutralVariant60,
              //     ),
              //   ),
              // ],
              if (isDesk)
                KSizedBox.kHeightSizedBox24
              else
                KSizedBox.kHeightSizedBox16,
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: KPadding.kPaddingSize16,
                ),
                child: Row(
                  spacing: KPadding.kPaddingSize16,
                  children: [
                    Text(
                      context.l10n.donotYouHavenAccount,
                      key: LoginKeys.signUpText,
                      style: AppTextStyle.materialThemeTitleMedium,
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          key: LoginKeys.signUpButton,
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
                color: AppColors.materialThemeRefNeutralNeutral90,
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
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child:
              SignUpLoginServiceWidget(
                // key: SignUpBottomButtonsKeys.google,
                // text: context.l10n.google,
                // picture: KImage.google(),
                // onPressed: () => context
                //     .read<AuthenticationServicesCubit>()
                //     .authenticationUseGoogle(),
                isDesk: isDesk,
              ),

              // ),
              if (!isDesk) KSizedBox.kHeightSizedBox24,
            ],
          );
        },
      ),
    );
  }

  bool showPassword(LoginEnum current) =>
      current == LoginEnum.passwordInProgress ||
      current == LoginEnum.showPassword ||
      current == LoginEnum.passwordInvalidData;
}
