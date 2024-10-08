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
    return BlocConsumer<PasswordResetBloc, PasswordResetState>(
      listener: (context, state) {
        if (state.formState == PasswordResetEnum.success) {
          context.goNamed(KRoute.login.name);
        }
      },
      builder: (context, _) {
        return ScaffoldWidget(
          titleDeskPadding: _.formState == PasswordResetEnum.initial
              ? null
              : ({required maxWidth}) => maxWidth.screenPadding(
                    precent: KDimensions.twentyPercent,
                  ),
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
                title: _.formState == PasswordResetEnum.initial
                    ? context.l10n.passwordReset
                    : context.l10n.successfully,
                isDesk: isDesk,
                mainAxisAlignment: MainAxisAlignment.center,
                expanded: !isDesk,
              ),
            ),
            if (isDesk)
              KSizedBox.kHeightSizedBox16
            else
              KSizedBox.kHeightSizedBox8,
            if (_.failure == PasswordResetFailure.wrongCode)
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
                      text: context.l10n.passwordResetWrongDescriptionSecond,
                      style: AppTextStyle.materialThemeBodyLargeBold,
                    ),
                  ],
                ),
              )
            else
              Text(
                _.formState == PasswordResetEnum.initial
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
          mainChildWidgetsFunction: ({required isDesk, required isTablet}) => [
            if (_.formState != PasswordResetEnum.initial) ...[
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
                enabled: _.failure != PasswordResetFailure.wrongCode,
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
                showErrorText: _.formState == PasswordResetEnum.invalidData ||
                    _.formState == PasswordResetEnum.passwordMismatch,
                enabled: _.failure != PasswordResetFailure.wrongCode,
              ),
            ],
            if (isDesk) ...[
              if (_.failure != null) KSizedBox.kHeightSizedBox40,
              KSizedBox.kHeightSizedBox24,
            ] else
              KSizedBox.kHeightSizedBox16,
            if (_.failure != null || _.formState != PasswordResetEnum.initial)
              Align(
                alignment:
                    _.failure != null ? Alignment.center : Alignment.centerLeft,
                child: DoubleButtonWidget(
                  widgetKey: KWidgetkeys.screen.passwordReset.confirmButton,
                  align: _.failure != null ? Alignment.center : null,
                  text: _.failure != null
                      ? context.l10n.sendAgain
                      : context.l10n.confirm,
                  onPressed: _.failure != null
                      ? () => context.goNamed(KRoute.pwResetEmail.name)
                      : () => context.read<PasswordResetBloc>().add(
                            PasswordResetEvent.resetPassword(code),
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
              failureText: _.formState != PasswordResetEnum.initial
                  ? _.failure?.value(context)
                  : null,
              sendingText: _.formState == PasswordResetEnum.sending
                  ? context.l10n.changePasswordWaiting
                  : null,
              successText: _.formState == PasswordResetEnum.success
                  ? context.l10n.changedPassword
                  : null,
            ),
            if (isDesk)
              KSizedBox.kHeightSizedBox80
            else
              KSizedBox.kHeightSizedBox24,
          ],
        );
      },
    );
  }
}
