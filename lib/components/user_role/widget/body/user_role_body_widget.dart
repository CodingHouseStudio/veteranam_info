import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared.dart';

class UserRoleBodyWidget extends StatelessWidget {
  const UserRoleBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      mainDeskPadding: ({required isDesk, required maxWidth}) =>
          EdgeInsets.symmetric(
        horizontal: maxWidth > KMinMaxSize.maxWidth640 ? maxWidth * 0.3 : 0,
        vertical: isDesk ? KPadding.kPaddingSize80 : KPadding.kPaddingSize24,
      ),
      mainChildWidgetsFunction: ({required isDesk, required isTablet}) => [
        DecoratedBox(
          decoration: KWidgetTheme.boxDecorationHome,
          child: Padding(
            padding: const EdgeInsets.all(KPadding.kPaddingSize32),
            child: Column(
              crossAxisAlignment:
                  isDesk ? CrossAxisAlignment.center : CrossAxisAlignment.start,
              children: [
                Text(
                  key: KWidgetkeys.screen.userRole.title,
                  context.l10n.userRole,
                  style: isDesk
                      ? AppTextStyle.materialThemeHeadlineLarge
                      : AppTextStyle.materialThemeHeadlineSmall,
                ),
                KSizedBox.kHeightSizedBox16,
                Text(
                  key: KWidgetkeys.screen.userRole.subtitle,
                  context.l10n.userRoleSubtitle,
                  style: AppTextStyle.materialThemeBodyLarge,
                ),
                if (isDesk)
                  KSizedBox.kHeightSizedBox24
                else
                  KSizedBox.kHeightSizedBox32,
                DoubleButtonWidget(
                  align: Alignment.center,
                  widgetKey: KWidgetkeys.screen.userRole.businessButton,
                  text: context.l10n.signUpBusiness,
                  isDesk: isDesk,
                  onPressed: null,
                  color: AppColors.materialThemeKeyColorsPrimary,
                  textColor: AppColors.materialThemeBlack,
                  mobHorizontalTextPadding: KPadding.kPaddingSize40,
                  mobVerticalTextPadding: KPadding.kPaddingSize16,
                ),
                KSizedBox.kHeightSizedBox24,
                Center(
                  child: TextButton(
                    key: KWidgetkeys.screen.userRole.userButton,
                    onPressed: () => context.goNamed(KRoute.signUp.name),
                    style: KButtonStyles.borderBlackButtonStyle,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: KPadding.kPaddingSize12,
                        horizontal: KPadding.kPaddingSize12,
                      ),
                      child: Text(
                        context.l10n.signUpUser,
                        style: AppTextStyle.materialThemeTitleMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox24
        else
          KSizedBox.kHeightSizedBox32,
        Row(
          key: KWidgetkeys.screen.userRole.loginButton,
          mainAxisAlignment:
              isDesk ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            Text(
              context.l10n.doYouHavenAccount,
              key: KWidgetkeys.screen.signUp.loginText,
              style: AppTextStyle.materialThemeTitleMedium,
            ),
            KSizedBox.kWidthSizedBox16,
            DropDownButton(
              isDesk: isDesk,
              buttonText: context.l10n.login,
              textItems: [
                context.l10n.asBusiness,
                context.l10n.asUser,
              ],
            ),
          ],
        ),
      ],
    );
  }
}
