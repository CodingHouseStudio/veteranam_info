import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared.dart';

class UserRoleBodyWidget extends StatelessWidget {
  const UserRoleBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      mainDeskPadding: ({required maxWidth}) => EdgeInsets.symmetric(
        horizontal: maxWidth > KMinMaxSize.maxWidth640
            ? maxWidth * KDimensions.kUserRoleWidth
            : 0,
        vertical: KPadding.kPaddingSize80,
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
                  widgetKey: KWidgetkeys.screen.userRole.signUpBusinessButton,
                  text: context.l10n.signUpBusiness,
                  isDesk: isDesk,
                  onPressed: null,
                  color: AppColors.materialThemeKeyColorsPrimary,
                  textColor: AppColors.materialThemeKeyColorsSecondary,
                  mobHorizontalTextPadding: KPadding.kPaddingSize40,
                  mobVerticalTextPadding: KPadding.kPaddingSize16,
                  deskIconPadding: KPadding.kPaddingSize16,
                  deskPadding: const EdgeInsets.symmetric(
                    vertical: KPadding.kPaddingSize16,
                    horizontal: KPadding.kPaddingSize30,
                  ),
                ),
                KSizedBox.kHeightSizedBox24,
                Center(
                  child: TextButton(
                    key: KWidgetkeys.screen.userRole.signUpUserButton,
                    onPressed: () => context.goNamed(KRoute.signUp.name),
                    style: KButtonStyles.borderBlackButtonStyle,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: KPadding.kPaddingSize16,
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
              items: [
                DropDownItem(
                  text: context.l10n.asBusiness,
                  action: null,
                  key: KWidgetkeys.screen.userRole.loginBusinessButton,
                ),
                DropDownItem(
                  text: context.l10n.asUser,
                  action: () => context.goNamed(KRoute.login.name),
                  key: KWidgetkeys.screen.userRole.loginUserButton,
                ),
              ],
              offset: KDimensions.offset,
            ),
          ],
        ),
      ],
    );
  }
}