import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:veteranam/components/pw_reset_email/bloc/pw_reset_email_bloc.dart';
import 'package:veteranam/components/pw_reset_email/pw_reset_email.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class PwResetEmailBodyWidget extends StatelessWidget {
  const PwResetEmailBodyWidget({required this.email, super.key});
  final String? email;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PwResetEmailBloc, PwResetEmailState>(
      builder: (context, _) {
        return ScaffoldWidget(
          titleDeskPadding: ({required maxWidth}) => maxWidth.screenPadding(
            precent: KDimensions.twentyPercent,
          ),
          showAppBar: Config.isWeb,
          showMobBottomNavigation: false,
          titleChildWidgetsFunction: ({required isDesk}) => [
            if (!Config.isWeb && !_.formState.isSended) ...[
              KSizedBox.kHeightSizedBox8,
              BackButtonWidget(
                backPageName: null,
                pathName: KRoute.login.name,
              ),
            ],
            if (isDesk)
              KSizedBox.kHeightSizedBox80
            else
              KSizedBox.kHeightSizedBox24,
            Padding(
              padding: isDesk
                  ? const EdgeInsets.only(left: KPadding.kPaddingSize60)
                  : EdgeInsets.zero,
              child: ShortTitleIconWidget(
                title: context.l10n.passwordReset,
                titleKey: PwResetEmailKeys.title,
                isDesk: isDesk,
                titleAlign: isDesk ? TextAlign.center : TextAlign.start,
                expanded: true,
                // expanded: true,
              ),
            ),
            if (isDesk)
              KSizedBox.kHeightSizedBox16
            else
              KSizedBox.kHeightSizedBox8,
          ],
          mainDeskPadding: ({required maxWidth}) => maxWidth.screenPadding(
            precent: KDimensions.thirtyPercent,
          ),
          mainChildWidgetsFunction: ({required isDesk, required isTablet}) => [
            Padding(
              padding: _.formState.isSended && isDesk
                  ? const EdgeInsets.symmetric(
                      horizontal: KPadding.kPaddingSize32,
                    )
                  : EdgeInsets.zero,
              child: _.formState.isSended
                  // Android not support RichText Widget
                  ? Text.rich(
                      key: PwResetEmailKeys.resendSubtitle,
                      TextSpan(
                        style: AppTextStyle.materialThemeBodyLarge,
                        children: [
                          TextSpan(
                            text: context.l10n.passwordResetCodeSendFirst,
                          ),
                          TextSpan(
                            text: ' ${_.email.value}',
                            style: AppTextStyle.materialThemeBodyLargeBold,
                          ),
                          TextSpan(
                            text: context.l10n.passwordResetCodeSendSecond,
                            style: AppTextStyle.materialThemeBodyLargeBold,
                          ),
                          TextSpan(
                            text: context.l10n.passwordResetCodeSendThirty,
                          ),
                        ],
                      ),
                      textAlign: isDesk ? TextAlign.center : TextAlign.start,
                    )
                  : Text(
                      context.l10n.passwordResetDescription,
                      key: PwResetEmailKeys.subtitle,
                      style: AppTextStyle.materialThemeBodyLarge,
                      textAlign: isDesk ? TextAlign.center : TextAlign.start,
                    ),
            ),
            if (_.formState.isSended) ...[
              KSizedBox.kHeightSizedBox16,
              Align(
                alignment: isDesk ? Alignment.topCenter : Alignment.topLeft,
                child: TextButton(
                  key: PwResetEmailKeys.cancelButton,
                  onPressed: () => context
                      .read<PwResetEmailBloc>()
                      .add(const PwResetEmailEvent.resetStatus()),
                  style: KButtonStyles.borderBlackButtonPwResetStyle,
                  child: Text(
                    context.l10n.back,
                    style: AppTextStyle.materialThemeTitleMedium,
                  ),
                ),
              ),
            ],
            if (_.formState.isSended)
              KSizedBox.kHeightSizedBox80
            else
              KSizedBox.kHeightSizedBox40,
            PwResetEmailFormWidget(
              isDesk: isDesk,
              email: email,
            ),
            SendingTextWidget(
              textKey: PwResetEmailKeys.submitingText,
              failureText: _.failure?.value(context),
              sendingText: context.l10n.passwordResetCodeSending,
              successText: null,
              showSendingText: _.formState.isSending,
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
