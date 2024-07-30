import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared.dart';

class MenuDialogWidget extends StatelessWidget {
  const MenuDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: TextButton.icon(
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
          context: context,
          routeName: KRoute.investors.name,
          text: context.l10n.investors,
        ),
        KSizedBox.kHeightSizedBox32,
        _button(
          context: context,
          routeName: KRoute.feedback.name,
          text: context.l10n.contact,
        ),
        KSizedBox.kHeightSizedBox32,
        Wrap(
          children: [
            const LanguagesSwitcherWidget(),
            KSizedBox.kWidthSizedBox30,
            ...FooterWidget.socialMediaLinks(
              isTablet: true,
              context: context,
              padding: KSizedBox.kWidthSizedBox8,
              instagramKey: const Key('value'),
              linkedInKey: const Key('linkedInKey'),
              facebookKey: const Key('facebookKey'),
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
  }) =>
      SizedBox(
        width: double.infinity,
        child: TextButton(
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
