import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:veteranam/shared/shared.dart';

class UserRoleBodyWidget extends StatelessWidget {
  const UserRoleBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldDecorationWidget(
      key: KWidgetkeys.screen.signUp.card,
      mainPadding: ({required isDesk, required maxWidth}) =>
          EdgeInsets.symmetric(
        horizontal: maxWidth > KMinMaxSize.maxWidth640 ? maxWidth * 0.2 : 0,
        vertical: isDesk ? KPadding.kPaddingSize80 : KPadding.kPaddingSize24,
      ),
      mainDecoration: KWidgetTheme.boxDecorNeutralVariant,
      mainChildWidgetsFunction: ({required isDesk}) => [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                context.l10n.signUp,
                key: KWidgetkeys.screen.signUp.title,
                style: isDesk
                    ? AppTextStyle.materialThemeDisplayLarge
                    : AppTextStyle.materialThemeDisplaySmall,
              ),
            ),
            if (isDesk)
              KSizedBox.kWidthSizedBox32
            else
              KSizedBox.kWidthSizedBox24,
            IconWidget(
              icon: KIcon.arrowDownLeft,
              padding:
                  isDesk ? KPadding.kPaddingSize20 : KPadding.kPaddingSize8,
            ),
          ],
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox40
        else
          KSizedBox.kHeightSizedBox24,

        if (isDesk)
          KSizedBox.kHeightSizedBox24
        else
          KSizedBox.kHeightSizedBox16,
        // Align(
        //   alignment: Alignment.centerLeft,
        //   child:
        //   DoubleButtonWidget(
        //     widgetKey: KWidgetkeys.screen.signUp.button,
        //     text: _.showPasswordField
        //         ? context.l10n.login
        //         : context.l10n.next,
        //     onPressed: () => context.read<SignUpBloc>().add(
        //           const SignUpEvent.signUpSubmitted(),
        //         ),
        //     isDesk: false,
        //     color: AppColors.materialThemeKeyColorsSecondary,
        //     textColor: AppColors.materialThemeWhite,
        //     mobTextWidth: isDesk ? null : double.infinity,
        //     mobHorizontalTextPadding: KPadding.kPaddingSize60,
        //     mobVerticalTextPadding: KPadding.kPaddingSize12,
        //     mobIconPadding: KPadding.kPaddingSize12,
        //   ),
        // ),
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
              // Expanded(
              //   child: Align(
              //     alignment: Alignment.centerLeft,
              //     child: TextButton(
              //       key: KWidgetkeys.screen.signUp.loginButton,
              //       onPressed: () => context.goNamed(KRoute.login.name),
              //       style: KButtonStyles.borderBlackButtonStyle,
              //       child: Text(
              //         context.l10n.login,
              //         style: isDesk
              //             ? AppTextStyle.materialThemeTitleMedium
              //             : AppTextStyle.materialThemeTitleSmall,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
