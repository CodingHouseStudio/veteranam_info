import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/sign_up/bloc/sign_up_bloc.dart';
import 'package:veteranam/components/sign_up/sign_up.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class SignUpBodyWidget extends StatelessWidget {
  const SignUpBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SignUpBlocListener(
      child: BlocBuilder<SignUpBloc, SignUpState>(
        // listener: (context, state) => context.dialog.showSnackBardTextDialog(
        //   state.failure?.value(context),
        // ),
        builder: (context, _) {
          return ScaffoldWidget(
            key: SignUpKeys.card,
            mainDeskPadding: ({required maxWidth}) => maxWidth.screenPadding(
              precent: KDimensions.thirtyPercent,
              verticalPadding: KPadding.kPaddingSize80,
              notUseHorizontal: maxWidth > KMinMaxSize.maxWidth640,
            ),
            isForm: true,
            pageName: context.l10n.signUp,
            showMobBottomNavigation: true,
            bottomBarIndex: 3,
            showAppBar: Config.isWeb,
            mainChildWidgetsFunction: ({required isDesk, required isTablet}) =>
                [
              if (!isDesk) KSizedBox.kHeightSizedBox24,
              ShortTitleIconWidget(
                title: context.l10n.signUp,
                titleKey: SignUpKeys.title,
                isDesk: isDesk,
                expanded: isDesk,
              ),
              if (isDesk)
                KSizedBox.kHeightSizedBox40
              else
                KSizedBox.kHeightSizedBox24,
              EmailPasswordFieldsWidget(
                key: SignUpKeys.fields,
                isDesk: isDesk,
                showPassword: showPassword(_.formState),
                onChangedEmail: (value) => context
                    .read<SignUpBloc>()
                    .add(SignUpEvent.emailUpdated(value)),
                onChangedPassword: (value) => context
                    .read<SignUpBloc>()
                    .add(SignUpEvent.passwordUpdated(value)),
                errorTextEmail: _.email.error.value(context),
                errorTextPassword: _.password.error.value(context),
                email: context.read<SignUpBloc>().state.email.value,
                backPassword: () => context.read<SignUpBloc>().add(
                      const SignUpEvent.passwordFieldHide(),
                    ),
                isLogin: false,
                showErrorText: _.formState == SignUpEnum.invalidData ||
                    _.formState == SignUpEnum.passwordInvalidData,
                // bottomError: _.failure?.value(context),
                // bottomTextKey: SignUpKeys.errorText,
              ),
              if (isDesk)
                KSizedBox.kHeightSizedBox24
              else
                KSizedBox.kHeightSizedBox16,
              DoubleButtonWidget(
                widgetKey: SignUpKeys.button,
                text: showPassword(_.formState)
                    ? context.l10n.register
                    : context.l10n.next,
                onPressed: () => context.read<SignUpBloc>().add(
                      const SignUpEvent.signUpSubmitted(),
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
                textKey: SignUpKeys.submitingText,
                failureText: _.failure?.value(context),
                sendingText: context.l10n.signingUpWait,
                successText: null,
                showSendingText: _.formState == SignUpEnum.success,
              ),
              // if (_.formState == SignUpEnum.success) ...[
              //   KSizedBox.kHeightSizedBox16,
              //   Padding(
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: KPadding.kPaddingSize16,
              //     ),
              //     child: Text(
              //       context.l10n.loggingInWait,
              //       key: SignUpKeys.loadingText,
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
                      context.l10n.doYouHavenAccount,
                      key: SignUpKeys.loginText,
                      style: AppTextStyle.materialThemeTitleMedium,
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          key: SignUpKeys.loginButton,
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
                context.l10n.signUpInWith,
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

  bool showPassword(SignUpEnum current) =>
      current == SignUpEnum.passwordInProgress ||
      current == SignUpEnum.showPassword ||
      current == SignUpEnum.passwordInvalidData;
}
