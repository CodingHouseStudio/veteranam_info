import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/sign_up/sign_up.dart';
import 'package:veteranam/shared/shared.dart';

class SignUpBodyWidget extends StatelessWidget {
  const SignUpBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      // listener: (context, state) => context.dialog.showSnackBardTextDialog(
      //   state.failure?.value(context),
      // ),
      builder: (context, _) {
        return ScaffoldDecorationWidget(
          key: KWidgetkeys.screen.signUp.card,
          mainPadding: ({required isDesk, required maxWidth}) =>
              maxWidth.screenPadding(
            precent:
                isDesk ? KDimensions.thirtyPercent : KDimensions.fifteenPercent,
            verticalPadding:
                isDesk ? KPadding.kPaddingSize80 : KPadding.kPaddingSize24,
            notUseHorizontal: maxWidth > KMinMaxSize.maxWidth640,
          ),
          mainChildWidgetsFunction: ({required isDesk}) => [
            ShortTitleIconWidget(
              title: context.l10n.signUp,
              titleKey: KWidgetkeys.screen.signUp.title,
              isDesk: isDesk,
              expanded: isDesk,
            ),
            if (isDesk)
              KSizedBox.kHeightSizedBox40
            else
              KSizedBox.kHeightSizedBox24,
            EmailPasswordFieldsWidget(
              key: KWidgetkeys.screen.signUp.fields,
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
              // bottomTextKey: KWidgetkeys.screen.signUp.errorText,
            ),
            if (isDesk)
              KSizedBox.kHeightSizedBox24
            else
              KSizedBox.kHeightSizedBox16,
            Align(
              alignment: Alignment.centerLeft,
              child: DoubleButtonWidget(
                widgetKey: KWidgetkeys.screen.signUp.button,
                text: showPassword(_.formState)
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
            SendingTextWidget(
              textKey: KWidgetkeys.screen.signUp.submitingText,
              failureText: _.failure?.value(context),
              sendingText: context.l10n.loggingInWait,
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
            //       key: KWidgetkeys.screen.signUp.loadingText,
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
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child:
            SignUpLoginServiceWidget(
              // key: KWidgetkeys.widget.signUpBottomButtons.google,
              // text: context.l10n.google,
              // picture: KImage.google(),
              // onPressed: () => context
              //     .read<AuthenticationServicesCubit>()
              //     .authenticationUseGoogle(),
              isDesk: isDesk,
            ),
            // ),
          ],
        );
      },
    );
  }

  bool showPassword(SignUpEnum current) =>
      current == SignUpEnum.passwordInProgress ||
      current == SignUpEnum.showPassword ||
      current == SignUpEnum.passwordInvalidData;
}
