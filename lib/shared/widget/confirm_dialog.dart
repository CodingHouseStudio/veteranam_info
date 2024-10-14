import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    required this.isDesk,
    required this.title,
    required this.subtitle,
    required this.confirmText,
    required this.confirmButtonBackground,
    this.unconfirmText,
    this.onPressed,
    super.key,
  });
  final bool isDesk;
  final String title;
  final String subtitle;
  final String confirmText;
  final void Function()? onPressed;
  final Color confirmButtonBackground;
  final String? unconfirmText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                title,
                key: KWidgetkeys.widget.dialogs.profileTitle,
                style: isDesk
                    ? AppTextStyle.materialThemeHeadlineLarge
                    : AppTextStyle.materialThemeHeadlineSmall,
              ),
            ),
            IconButtonWidget(
              icon: KIcon.close,
              key: KWidgetkeys.widget.dialogs.icon,
              onPressed: () => context.pop(),
              padding: 0,
              color: AppColors.materialThemeKeyColorsNeutralVariant,
              background: AppColors.materialThemeWhite,
            ),
          ],
        ),
        if (isDesk) KSizedBox.kHeightSizedBox16 else KSizedBox.kHeightSizedBox8,
        Text(
          subtitle,
          key: KWidgetkeys.widget.dialogs.profileSubtitle,
          style: isDesk
              ? AppTextStyle.materialThemeBodyLarge
              : AppTextStyle.materialThemeBodyMedium,
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox32
        else
          KSizedBox.kHeightSizedBox24,
        if (isDesk)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              confirmButton(),
              KSizedBox.kWidthSizedBox24,
              unconfirmButton(context),
            ],
          )
        else
          Column(
            children: [
              confirmButton(),
              KSizedBox.kHeightSizedBox16,
              unconfirmButton(context),
            ],
          ),
      ],
    );
  }

  DoubleButtonWidget confirmButton() {
    return DoubleButtonWidget(
      widgetKey: KWidgetkeys.widget.dialogs.confirmButton,
      text: confirmText,
      color: confirmButtonBackground,
      textColor: AppColors.materialThemeWhite,
      isDesk: isDesk,
      deskPadding: const EdgeInsets.symmetric(
        vertical: KPadding.kPaddingSize12,
        horizontal: KPadding.kPaddingSize30,
      ),
      mobTextWidth: double.infinity,
      mobVerticalTextPadding: KPadding.kPaddingSize16,
      mobIconPadding: KPadding.kPaddingSize16,
      onPressed: onPressed,
    );
  }

  TextButton unconfirmButton(BuildContext context) {
    return TextButton(
      key: KWidgetkeys.widget.dialogs.unconfirmButton,
      onPressed: () => context.pop(),
      style: isDesk
          ? KButtonStyles.borderBlackButtonStyle
          : KButtonStyles.borderBlackButtonStyle.copyWith(
              minimumSize: const WidgetStatePropertyAll(
                Size(double.infinity, 0),
              ),
            ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: KPadding.kPaddingSize12,
          horizontal: KPadding.kPaddingSize12,
        ),
        child: Text(
          unconfirmText ?? context.l10n.cancel,
          style: AppTextStyle.materialThemeTitleMedium,
        ),
      ),
    );
  }
}
