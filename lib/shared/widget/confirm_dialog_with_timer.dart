// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class ConfirmDialogWithTimer extends StatefulWidget {
  const ConfirmDialogWithTimer({
    required this.isDesk,
    required this.title,
    required this.subtitle,
    required this.confirmText,
    required this.confirmButtonBackground,
    required this.timer,
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
  final bool timer;

  @override
  State<ConfirmDialogWithTimer> createState() => _ConfirmDialogWithTimerState();
}

class _ConfirmDialogWithTimerState extends State<ConfirmDialogWithTimer> {
  Timer? _timer;
  int _remainingTime = 10;
  bool _isButtonEnabled = false;

  @override
  void initState() {
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
    return ConfirmDialog(
      isDesk: widget.isDesk,
      title: widget.title,
      subtitle: widget.subtitle,
      confirmText: widget.confirmText,
      confirmButtonBackground: _isButtonEnabled
          ? widget.confirmButtonBackground
          : AppColors.materialThemeRefNeutralVariantNeutralVariant80,
      onPressed: _isButtonEnabled ? widget.onPressed : null,
      unconfirmText: widget.unconfirmText,
      timer: (widget.timer && !_isButtonEnabled)
          ? Text(
              '${context.l10n.enableButton} $_remainingTime ${context.l10n.seconds}',
              style: AppTextStyle.materialThemeBodySmall,
            )
          : null,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
