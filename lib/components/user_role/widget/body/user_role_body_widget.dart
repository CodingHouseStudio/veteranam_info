import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class UserRoleBodyWidget extends StatelessWidget {
  const UserRoleBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      mainDeskPadding: ({required maxWidth}) => EdgeInsets.symmetric(
        horizontal: maxWidth < KPlatformConstants.maxWidthThresholdTablet
            ? maxWidth * KDimensions.twentyPercent
            : maxWidth * KDimensions.thirtyPercent,
        vertical: KPadding.kPaddingSize120,
      ),
      showMobNawbarBackButton: true,
      showMobBottomNavigation: false,
      pageName: context.l10n.joinUs,
      mainChildWidgetsFunction: ({required isDesk, required isTablet}) => [
        if (!isDesk) KSizedBox.kHeightSizedBox24,
        DecoratedBox(
          decoration: KWidgetTheme.boxDecorationHome,
          child: Padding(
            padding: const EdgeInsets.all(KPadding.kPaddingSize32),
            child: Column(
              children: [
                Text(
                  key: KWidgetkeys.screen.userRole.title,
                  context.l10n.userRole,
                  style: isDesk
                      ? AppTextStyle.materialThemeHeadlineLarge
                      : AppTextStyle.materialThemeHeadlineSmall,
                  textAlign: isDesk ? TextAlign.center : TextAlign.start,
                ),
                KSizedBox.kHeightSizedBox16,
                Text(
                  key: KWidgetkeys.screen.userRole.subtitle,
                  context.l10n.userRoleSubtitle,
                  style: AppTextStyle.materialThemeBodyLarge,
                  textAlign: isDesk ? TextAlign.center : TextAlign.start,
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
                  onPressed: () => context.read<UrlCubit>().launchUrl(
                        url: '${KAppText.businessSite}/${KRoute.signUp.path}',
                      ),
                  color: AppColors.materialThemeKeyColorsPrimary,
                  textColor: AppColors.materialThemeKeyColorsSecondary,
                  mobHorizontalTextPadding: KPadding.kPaddingSize40,
                  mobVerticalTextPadding: KPadding.kPaddingSize16,
                  mobIconPadding: KPadding.kPaddingSize16,
                  deskIconPadding: KPadding.kPaddingSize16,
                  deskPadding: const EdgeInsets.symmetric(
                    vertical: KPadding.kPaddingSize16,
                    horizontal: KPadding.kPaddingSize52,
                  ),
                ),
                KSizedBox.kHeightSizedBox24,
                Center(
                  child: TextButton(
                    key: KWidgetkeys.screen.userRole.signUpUserButton,
                    onPressed: () => context.goNamed(KRoute.signUp.name),
                    style: KButtonStyles.borderBlackButtonStyle,
                    child: Padding(
                      padding: isDesk
                          ? const EdgeInsets.symmetric(
                              vertical: KPadding.kPaddingSize16,
                              horizontal: KPadding.kPaddingSize30,
                            )
                          : const EdgeInsets.symmetric(
                              vertical: KPadding.kPaddingSize12,
                              horizontal: KPadding.kPaddingSize24,
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
            PopupMenuButtonWidget<int>(
              buttonText: context.l10n.login,
              style: KButtonStyles.borderBlackButtonStyle.copyWith(
                padding: const WidgetStatePropertyAll(
                  EdgeInsets.only(
                    left: KPadding.kPaddingSize10,
                    right: KPadding.kPaddingSize22,
                  ),
                ),
              ),
              items: [
                DropDownItem(
                  text: context.l10n.asBusiness,
                  event: () => context.read<UrlCubit>().launchUrl(
                        url: '${KAppText.businessSite}/${KRoute.login.path}',
                      ),
                  key: KWidgetkeys.screen.userRole.loginBusinessButton,
                ),
                DropDownItem(
                  text: context.l10n.asUser,
                  event: () => context.goNamed(KRoute.login.name),
                  key: KWidgetkeys.screen.userRole.loginUserButton,
                ),
              ],
              buttonStyle: KButtonStyles.borderBlackButtonStyle.copyWith(
                padding: const WidgetStatePropertyAll(
                  EdgeInsets.only(
                    left: KPadding.kPaddingSize8,
                    right: KPadding.kPaddingSize16,
                    top: KPadding.kPaddingSize4,
                    bottom: KPadding.kPaddingSize4,
                  ),
                ),
              ),
              position: isTablet
                  ? PopupMenuButtonPosition.bottomRight
                  : PopupMenuButtonPosition.bottomCenter,
            ),
          ],
        ),
      ],
    );
  }
}
