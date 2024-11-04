// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:veteranam/shared/shared_flutter.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    required this.isDesk,
    required this.title,
    required this.subtitle,
    required this.confirmText,
    required this.confirmButtonBackground,
    this.onPressed,
    this.unconfirmText,
    this.timer,
    super.key,
  });

  final bool isDesk;
  final String title;
  final String subtitle;
  final String confirmText;
  final void Function()? onPressed;
  final Color confirmButtonBackground;
  final String? unconfirmText;
  final Text? timer;

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
              key: KWidgetkeys.widget.confirmDialog.icon,
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
                Padding(
                  padding:
                      const EdgeInsets.only(right: KPadding.kPaddingSize24),
                  child: Text(
                    title,
                    key: KWidgetkeys.widget.confirmDialog.title,
                    style: isDesk
                        ? AppTextStyle.materialThemeHeadlineLarge
                        : AppTextStyle.materialThemeHeadlineSmall,
                  ),
                ),
                if (isDesk)
                  KSizedBox.kHeightSizedBox16
                else
                  KSizedBox.kHeightSizedBox8,
                Text(
                  subtitle,
                  key: KWidgetkeys.widget.confirmDialog.subtitle,
                  style: isDesk
                      ? AppTextStyle.materialThemeBodyLarge
                      : AppTextStyle.materialThemeBodyMedium,
                ),
                if (isDesk)
                  KSizedBox.kHeightSizedBox32
                else
                  KSizedBox.kHeightSizedBox24,
                // if (widget.isDesk)
                Wrap(
                  spacing: KPadding.kPaddingSize24,
                  runSpacing: KPadding.kPaddingSize16,
                  children: [
                    confirmButton(),
                    if (timer != null && !isDesk) ...[
                      KSizedBox.kHeightSizedBox8,
                      timer!,
                    ],
                    unconfirmButton(context),
                  ],
                ),
                // else
                //   Column(
                //     children: [
                //       confirmButton(),
                //       if (widget.timer && !_isButtonEnabled) ...[
                //         KSizedBox.kHeightSizedBox8,
                //         Text(
                //           '${context.l10n.enableButton} $_remainingTime ${context.l10n.seconds}',
                //           style: AppTextStyle.materialThemeBodySmall,
                //         ),
                //       ],
                //       KSizedBox.kHeightSizedBox16,
                //       unconfirmButton(context),
                //     ],
                //   ),
                if (!isDesk) KSizedBox.kHeightSizedBox16,
                if (timer != null && isDesk) ...[
                  KSizedBox.kHeightSizedBox8,
                  timer!,
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget confirmButton() {
    return DoubleButtonWidget(
      widgetKey: KWidgetkeys.widget.confirmDialog.confirmButton,
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
      hasAlign: !isDesk,
    );
  }

  Widget unconfirmButton(BuildContext context) {
    return SecondaryButtonWidget(
      widgetKey: KWidgetkeys.widget.confirmDialog.unconfirmButton,
      onPressed: context.pop,
      padding: const EdgeInsets.symmetric(
        vertical: KPadding.kPaddingSize12,
        horizontal: KPadding.kPaddingSize12,
      ),
      expanded: !isDesk,
      isDesk: isDesk,
      text: unconfirmText ?? context.l10n.cancel,
      hasAlign: !isDesk,
    );
  }
}
