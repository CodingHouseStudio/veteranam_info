import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared.dart';

class MenuDialogWidget extends StatelessWidget {
  const MenuDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: KWidgetkeys.widget.menuDialog.dialog,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: TextButton.icon(
            key: KWidgetkeys.widget.menuDialog.discountsButton,
            onPressed: () => context
              ..pop()
              ..goNamed(KRoute.discounts.name),
            icon: Text(
              context.l10n.discounts,
              style: AppTextStyle.materialThemeTitleMedium,
            ),
            label: const IconWidget(
              icon: KIcon.tag,
              background: AppColors.materialThemeSourceSeed,
              padding: KPadding.kPaddingSize8,
            ),
            style: KButtonStyles.withoutStyle,
          ),
        ),
        KSizedBox.kHeightSizedBox32,
        _button(
          key: KWidgetkeys.widget.menuDialog.investorsButton,
          context: context,
          routeName: KRoute.support.name,
          text: context.l10n.investors,
        ),
        KSizedBox.kHeightSizedBox32,
        _button(
          key: KWidgetkeys.widget.menuDialog.feedbackButton,
          context: context,
          routeName: KRoute.feedback.name,
          text: context.l10n.contact,
        ),
        KSizedBox.kHeightSizedBox32,
        Wrap(
          runSpacing: KPadding.kPaddingSize10,
          children: [
            LanguagesSwitcherWidget(
              key: KWidgetkeys.widget.menuDialog.languageSwitcher,
            ),
            KSizedBox.kWidthSizedBox30,
            ...FooterWidget.socialMediaLinks(
              isTablet: true,
              context: context,
              padding: KSizedBox.kWidthSizedBox8,
              instagramKey: KWidgetkeys.widget.menuDialog.instagram,
              linkedInKey: KWidgetkeys.widget.menuDialog.linkedIn,
              facebookKey: KWidgetkeys.widget.menuDialog.facebook,
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
            ..pop()
            ..goNamed(routeName),
          style: KButtonStyles.withoutStyle,
          child: Text(
            text,
            style: AppTextStyle.materialThemeTitleMedium,
          ),
        ),
      );
}
