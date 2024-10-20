// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared.dart';

class ConfirmDialog extends StatefulWidget {
  const ConfirmDialog({
    required this.isDesk,
    required this.title,
    required this.subtitle,
    required this.confirmText,
    required this.confirmButtonBackground,
    this.unconfirmText,
    this.onPressed,
    this.timer = false,
    super.key,
  });

  final bool isDesk;
  final String title;
  final String subtitle;
  final String confirmText;
  final void Function()? onPressed;
  final Color confirmButtonBackground;
  final String? unconfirmText;
  final bool timer;

  @override
  State<ConfirmDialog> createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {
  Timer? _timer;
  int _remainingTime = 10;
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    if (widget.timer) {
      _startTimer();
    } else {
      _isButtonEnabled = true;
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _isButtonEnabled = true;
          _timer?.cancel();
        }
      });
    });
  }

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
              key: KWidgetkeys.widget.dialogs.icon,
              style: KButtonStyles.circularButtonStyle,
              onPressed: context.pop,
              icon: KIcon.close,
            ),
          ),
          Padding(
            padding: widget.isDesk
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
                    widget.title,
                    key: KWidgetkeys.widget.dialogs.profileTitle,
                    style: widget.isDesk
                        ? AppTextStyle.materialThemeHeadlineLarge
                        : AppTextStyle.materialThemeHeadlineSmall,
                  ),
                ),
                if (widget.isDesk)
                  KSizedBox.kHeightSizedBox16
                else
                  KSizedBox.kHeightSizedBox8,
                Text(
                  widget.subtitle,
                  key: KWidgetkeys.widget.dialogs.profileSubtitle,
                  style: widget.isDesk
                      ? AppTextStyle.materialThemeBodyLarge
                      : AppTextStyle.materialThemeBodyMedium,
                ),
                if (widget.isDesk)
                  KSizedBox.kHeightSizedBox32
                else
                  KSizedBox.kHeightSizedBox24,
                // if (widget.isDesk)
                Wrap(
                  spacing: KPadding.kPaddingSize24,
                  runSpacing: KPadding.kPaddingSize16,
                  children: [
                    confirmButton(),
                    if (!widget.isDesk &&
                        widget.timer &&
                        !_isButtonEnabled) ...[
                      KSizedBox.kHeightSizedBox8,
                      Text(
                        '${context.l10n.enableButton} $_remainingTime ${context.l10n.seconds}',
                        style: AppTextStyle.materialThemeBodySmall,
                      ),
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
                if (!widget.isDesk) KSizedBox.kHeightSizedBox16,
                if (widget.timer && !_isButtonEnabled && widget.isDesk) ...[
                  KSizedBox.kHeightSizedBox8,
                  Text(
                    '${context.l10n.enableButton} $_remainingTime ${context.l10n.seconds}',
                    style: AppTextStyle.materialThemeBodySmall,
                  ),
                ],
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
      text: widget.confirmText,
      color: _isButtonEnabled
          ? widget.confirmButtonBackground
          : AppColors.materialThemeRefNeutralVariantNeutralVariant80,
      textColor: AppColors.materialThemeWhite,
      isDesk: widget.isDesk,
      deskPadding: const EdgeInsets.symmetric(
        vertical: KPadding.kPaddingSize12,
        horizontal: KPadding.kPaddingSize30,
      ),
      mobTextWidth: double.infinity,
      mobVerticalTextPadding: KPadding.kPaddingSize16,
      mobIconPadding: KPadding.kPaddingSize16,
      onPressed: _isButtonEnabled ? widget.onPressed : null,
      hasAlign: !widget.isDesk,
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
      expanded: !widget.isDesk,
      isDesk: widget.isDesk,
      text: widget.unconfirmText ?? context.l10n.cancel,
      hasAlign: !widget.isDesk,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
