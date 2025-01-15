import 'dart:async';

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
    required this.timer,
    required this.confirmWhiteText,
    this.unconfirmText,
    super.key,
  });

  final bool isDesk;
  final String title;
  final String subtitle;
  final String confirmText;
  final Color confirmButtonBackground;
  final String? unconfirmText;
  final bool timer;
  final bool confirmWhiteText;

  @override
  Widget build(BuildContext context) {
    if (timer) {
      return _ConfirmDialogWithTimer(
        isDesk: isDesk,
        title: title,
        subtitle: subtitle,
        confirmText: confirmText,
        unconfirmText: unconfirmText,
        confirmButtonBackground: confirmButtonBackground,
        confirmWhiteText: confirmWhiteText,
      );
    } else {
      return _CommonConfirmDialog(
        isDesk: isDesk,
        title: title,
        subtitle: subtitle,
        confirmText: confirmText,
        unconfirmText: unconfirmText,
        confirmButtonBackground: confirmButtonBackground,
        confirmWhiteText: confirmWhiteText,
      );
    }
  }
}

class _CommonConfirmDialog extends StatelessWidget {
  const _CommonConfirmDialog({
    required this.isDesk,
    required this.title,
    required this.subtitle,
    required this.confirmText,
    required this.confirmButtonBackground,
    required this.confirmWhiteText,
    this.unconfirmText,
    this.timer,
  });

  final bool isDesk;
  final String title;
  final String subtitle;
  final String confirmText;
  final Color confirmButtonBackground;
  final String? unconfirmText;
  final Text? timer;
  final bool confirmWhiteText;

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
              key: ConfirmDialogKeys.cancelIcon,
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
                    key: ConfirmDialogKeys.title,
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
                  key: ConfirmDialogKeys.subtitle,
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
                    confirmButton(context),
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
                //           '${context.l10n.enableButton} $_remainingTime
                // ${context.l10n.seconds}',
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

  Widget confirmButton(BuildContext context) {
    return DoubleButtonWidget(
      widgetKey: ConfirmDialogKeys.confirmButton,
      text: confirmText,
      color: confirmButtonBackground,
      darkMode: confirmWhiteText,
      // textColor: AppColors.materialThemeWhite,
      isDesk: isDesk,
      deskPadding: const EdgeInsets.symmetric(
        vertical: KPadding.kPaddingSize12,
        horizontal: KPadding.kPaddingSize30,
      ),
      mobTextWidth: double.infinity,
      mobVerticalTextPadding: KPadding.kPaddingSize16,
      mobIconPadding: KPadding.kPaddingSize16,
      onPressed: () => context.pop(true),
      align: Alignment.center,
      hasAlign: !isDesk,
    );
  }

  Widget unconfirmButton(BuildContext context) {
    return SecondaryButtonWidget(
      widgetKey: ConfirmDialogKeys.unconfirmButton,
      onPressed: () {
        context.pop(false);
      },
      padding: const EdgeInsets.symmetric(
        vertical: KPadding.kPaddingSize12,
        horizontal: KPadding.kPaddingSize12,
      ),
      expanded: !isDesk,
      isDesk: isDesk,
      text: unconfirmText ?? context.l10n.cancel,
      hasAlign: !isDesk,
      align: Alignment.center,
    );
  }
}

class _ConfirmDialogWithTimer extends StatefulWidget {
  const _ConfirmDialogWithTimer({
    required this.isDesk,
    required this.title,
    required this.subtitle,
    required this.confirmText,
    required this.confirmButtonBackground,
    required this.confirmWhiteText,
    this.unconfirmText,
  });

  final bool isDesk;
  final String title;
  final String subtitle;
  final String confirmText;
  final Color confirmButtonBackground;
  final String? unconfirmText;
  final bool confirmWhiteText;

  @override
  State<_ConfirmDialogWithTimer> createState() =>
      _ConfirmDialogWithTimerState();
}

class _ConfirmDialogWithTimerState extends State<_ConfirmDialogWithTimer> {
  Timer? _timer;
  late int _remainingTime;
  late bool _isButtonEnabled;

  @override
  void initState() {
    _remainingTime = KDimensions.confirmdialogTimerDelay;
    _isButtonEnabled = false;
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 1) {
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
    return _CommonConfirmDialog(
      isDesk: widget.isDesk,
      title: widget.title,
      subtitle: widget.subtitle,
      confirmText: widget.confirmText,
      confirmButtonBackground: _isButtonEnabled
          ? widget.confirmButtonBackground
          : AppColors.materialThemeRefNeutralVariantNeutralVariant80,
      unconfirmText: widget.unconfirmText,
      timer: !_isButtonEnabled
          ? Text(
              '${context.l10n.enableButton} '
              '$_remainingTime ${context.l10n.seconds}',
              key: ConfirmDialogKeys.timer,
              style: AppTextStyle.materialThemeBodySmall,
            )
          : null,
      confirmWhiteText: widget.confirmWhiteText,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
