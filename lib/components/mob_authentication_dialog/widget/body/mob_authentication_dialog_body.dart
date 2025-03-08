import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/mob_authentication_dialog/mob_authentication_dialog.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class AuthenticationDialogBody extends StatelessWidget {
  const AuthenticationDialogBody({
    required this.appVersion,
    required this.state,
    super.key,
  });
  final MobAuthenticationDialogState state;

  final AppVersionEnum appVersion;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: KMinMaxSize.maxWidth328,
        maxHeight: KMinMaxSize.maxHeight480,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: KPadding.kPaddingSize24,
          top: KPadding.kPaddingSize16,
          right: KPadding.kPaddingSize24,
          left: KPadding.kPaddingSize24,
        ),
        child: Column(
          spacing: KPadding.kPaddingSize16,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              getText(context),
              textAlign: TextAlign.center,
              style: appVersion.isTablet
                  ? AppTextStyle.materialThemeBodyLargeBold
                  : AppTextStyle.materialThemeBodyMediumBold,
            ),
            confirmButton(context),
          ],
        ),
      ),
    );
  }

  String getText(BuildContext context) {
    switch (state) {
      case MobAuthenticationDialogState.login:
        return context.l10n.loginGreeting;
      case MobAuthenticationDialogState.signUp:
        return context.l10n.signUpSuccess;
    }
  }

  Widget confirmButton(BuildContext context) {
    return DoubleButtonWidget(
      widgetKey: const Key('test'),
      text: context.l10n.continueText,
      color: AppColors.materialThemeKeyColorsPrimary,
      isDesk: appVersion.isTablet,
      mobPadding: const EdgeInsets.only(
        top: KPadding.kPaddingSize12,
        bottom: KPadding.kPaddingSize12,
        right: KPadding.kPaddingSize8,
        // left: KPadding.kPaddingSize32,
      ),
      mobIconPadding: KPadding.kPaddingSize12,
      onPressed: () => context.goNamed(KRoute.discounts.name),
      hasAlign: !appVersion.isTablet,
      align: Alignment.center,
      mobTextWidth: double.infinity,
    );
  }
}
