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
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: KMinMaxSize.minHeight640),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Padding(
            padding: const EdgeInsets.all(KPadding.kPaddingSize8),
            child: IconButton(
              style: KButtonStyles.circularButtonStyle,
              onPressed: context.pop,
              icon: KIcon.close,
            ),
          ),
          Padding(
            padding: isDesk
                ? const EdgeInsets.symmetric(
                    horizontal: KPadding.kPaddingSize40,
                    vertical: KPadding.kPaddingSize32,
                  )
                : const EdgeInsets.all(KPadding.kPaddingSize16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  key: KWidgetkeys.widget.dialogs.profileTitle,
                  style: isDesk
                      ? AppTextStyle.materialThemeHeadlineLarge
                      : AppTextStyle.materialThemeHeadlineSmall,
                ),
                if (isDesk)
                  KSizedBox.kHeightSizedBox16
                else
                  KSizedBox.kHeightSizedBox8,
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
                      unconfirmButton(context),
                      KSizedBox.kWidthSizedBox24,
                      confirmButton(),
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
                if (!isDesk) KSizedBox.kHeightSizedBox16,
              ],
            ),
          ),
        ],
      ),
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

  Widget unconfirmButton(BuildContext context) {
    return SecondaryButtonWidget(
      widgetKey: KWidgetkeys.widget.dialogs.unconfirmButton,
      onPressed: context.pop,
      padding: const EdgeInsets.symmetric(
        vertical: KPadding.kPaddingSize12,
        horizontal: KPadding.kPaddingSize12,
      ),
      expanded: !isDesk,
      isDesk: isDesk,
      text: unconfirmText ?? context.l10n.cancel,
    );
  }
}
