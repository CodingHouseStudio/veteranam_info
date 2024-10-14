import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/password_reset/password_reset.dart';
import 'package:veteranam/shared/shared.dart';

class PasswordResetBodyWidget extends StatelessWidget {
  const PasswordResetBodyWidget({super.key, this.code});
  final String? code;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckVerificationCodeCubit, bool?>(
      builder: (context, codeIsValid) {
        return BlocConsumer<PasswordResetBloc, PasswordResetState>(
          listener: (context, state) {
            if (state.formState == PasswordResetEnum.success) {
              context.goNamed(KRoute.login.name);
            }
          },
          builder: (context, _) {
            return ScaffoldWidget(
              titleChildWidgetsFunction: ({required isDesk}) => [
                if (isDesk)
                  KSizedBox.kHeightSizedBox80
                else
                  KSizedBox.kHeightSizedBox24,
                Padding(
                  padding: isDesk
                      ? const EdgeInsets.only(left: KPadding.kPaddingSize60)
                      : EdgeInsets.zero,
                  child: ShortTitleIconWidget(
                    titleKey: KWidgetkeys.screen.passwordReset.title,
                    title: (codeIsValid ?? false)
                        ? context.l10n.successfully
                        : context.l10n.passwordReset,
                    isDesk: isDesk,
                    mainAxisAlignment: MainAxisAlignment.center,
                    expanded: !isDesk,
                  ),
                ),
                if (isDesk)
                  KSizedBox.kHeightSizedBox16
                else
                  KSizedBox.kHeightSizedBox8,
                if (!(codeIsValid ?? true))
                  RichText(
                    key: KWidgetkeys.screen.passwordReset.wrongLinkSubtitle,
                    textAlign: isDesk ? TextAlign.center : TextAlign.start,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: context.l10n.passwordResetWrongDescriptionFirst,
                          style: AppTextStyle.materialThemeBodyLarge,
                        ),
                        TextSpan(
                          text:
                              context.l10n.passwordResetWrongDescriptionSecond,
                          style: AppTextStyle.materialThemeBodyLargeBold,
                        ),
                      ],
                    ),
                  )
                else
                  Text(
                    codeIsValid == null
                        ? context.l10n.passwordResetWaiting
                        : context.l10n.successfullyDescruption,
                    key: KWidgetkeys.screen.passwordReset.subtitle,
                    style: AppTextStyle.materialThemeBodyLarge,
                    textAlign: isDesk ? TextAlign.center : TextAlign.start,
                  ),
              ],
              mainDeskPadding: ({required maxWidth}) => maxWidth.screenPadding(
                precent: KDimensions.thirtyThreePercent,
              ),
              mainChildWidgetsFunction:
                  ({required isDesk, required isTablet}) => [
                if (codeIsValid ?? false) ...[
                  KSizedBox.kHeightSizedBox40,
                  PasswordFieldWidget(
                    widgetKey: KWidgetkeys.screen.passwordReset.passwordField,
                    onChanged: (text) => context
                        .read<PasswordResetBloc>()
                        .add(PasswordResetEvent.passwordUpdated(text)),
                    errorText: _.password.error.value(context),
                    labelText: context.l10n.password,
                    isDesk: isDesk,
                    showErrorText: _.formState == PasswordResetEnum.invalidData,
                  ),
                  if (isDesk)
                    KSizedBox.kHeightSizedBox24
                  else
                    KSizedBox.kHeightSizedBox16,
                  PasswordFieldWidget(
                    widgetKey:
                        KWidgetkeys.screen.passwordReset.confirmPasswordField,
                    onChanged: (text) => context
                        .read<PasswordResetBloc>()
                        .add(PasswordResetEvent.confirmPasswordUpdated(text)),
                    errorText: _.formState == PasswordResetEnum.passwordMismatch
                        ? context.l10n.passwordMismatch
                        : _.password.error.value(context),
                    labelText: context.l10n.confirmPassword,
                    isDesk: isDesk,
                    showErrorText:
                        _.formState == PasswordResetEnum.invalidData ||
                            _.formState == PasswordResetEnum.passwordMismatch,
                  ),
                ],
                if (isDesk) ...[
                  if (!(codeIsValid ?? true)) KSizedBox.kHeightSizedBox40,
                  KSizedBox.kHeightSizedBox24,
                ] else
                  KSizedBox.kHeightSizedBox16,
                if (codeIsValid != null)
                  Align(
                    alignment:
                        codeIsValid ? Alignment.centerLeft : Alignment.center,
                    child: DoubleButtonWidget(
                      widgetKey: KWidgetkeys.screen.passwordReset.confirmButton,
                      align: codeIsValid ? null : Alignment.center,
                      text: codeIsValid
                          ? context.l10n.confirm
                          : context.l10n.sendAgain,
                      onPressed: codeIsValid
                          ? () => context.read<PasswordResetBloc>().add(
                                PasswordResetEvent.passwordReset(code),
                              )
                          : () => context.goNamed(KRoute.pwResetEmail.name),
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
                  )
                else
                  Center(
                    child: CircularProgressIndicator(
                      key: KWidgetkeys.screen.passwordReset.loadingIndicator,
                      backgroundColor: AppColors.materialThemeKeyColorsNeutral,
                      color: AppColors.materialThemeKeyColorsNeutralVariant,
                    ),
                  ),
                SendingTextWidget(
                  textKey: KWidgetkeys.screen.passwordReset.submitingText,
                  failureText: _.failure?.value(context),
                  sendingText: context.l10n.changePasswordWaiting,
                  successText: context.l10n.changedPassword,
                  showSendingText: _.formState == PasswordResetEnum.sending,
                  showSuccessText: _.formState == PasswordResetEnum.success,
                ),
                if (isDesk)
                  KSizedBox.kHeightSizedBox80
                else
                  KSizedBox.kHeightSizedBox24,
              ],
            );
          },
        );
      },
    );
  }
}
