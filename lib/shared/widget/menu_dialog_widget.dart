import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class MenuDialogWidget extends StatelessWidget {
  const MenuDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: MenuDialogKeys.dialog,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: KPadding.kPaddingSize32,
      children: [
        SizedBox(
          width: double.infinity,
          child: TextButton.icon(
            key: MenuDialogKeys.discountsButton,
            onPressed: () => context
              ..popDialog()
              ..goNamed(KRoute.discounts.name),
            iconAlignment: IconAlignment.end,
            icon: const IconWidget(
              icon: KIcon.tag,
              background: AppColors.materialThemeSourceSeed,
              padding: KPadding.kPaddingSize8,
            ),
            label: Text(
              context.l10n.discounts,
              style: AppTextStyle.materialThemeTitleMedium,
            ),
            style: KButtonStyles.withoutStyle,
          ),
        ),
        _button(
          key: MenuDialogKeys.investorsButton,
          context: context,
          routeName: KRoute.support.name,
          text: context.l10n.investors,
        ),
        _button(
          key: MenuDialogKeys.feedbackButton,
          context: context,
          routeName: KRoute.feedback.name,
          text: context.l10n.contact,
        ),
        const Wrap(
          runSpacing: KPadding.kPaddingSize10,
          spacing: KPadding.kPaddingSize30,
          children: [
            LanguagesSwitcherWidget(
              key: MenuDialogKeys.languageSwitcher,
            ),
            SocialMediaLinks(
              isDesk: false,
              padding: KPadding.kPaddingSize8,
              instagramKey: MenuDialogKeys.instagram,
              linkedInKey: MenuDialogKeys.linkedIn,
              facebookKey: MenuDialogKeys.facebook,
            ),
          ],
        ),
      ],
    );
  }

  Widget _button({
    required BuildContext context,
    required String routeName,
    required String text,
    required Key key,
  }) =>
      SizedBox(
        width: double.infinity,
        child: TextButton(
          key: key,
          onPressed: () => context
            ..popDialog()
            ..goNamed(routeName),
          style: KButtonStyles.withoutStyle,
          child: Text(
            text,
            style: AppTextStyle.materialThemeTitleMedium,
          ),
        ),
      );
}
