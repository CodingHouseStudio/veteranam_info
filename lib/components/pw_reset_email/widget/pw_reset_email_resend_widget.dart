import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/pw_reset_email/bloc/pw_reset_email_bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class PwResetEmailResendWidget extends StatefulWidget {
  const PwResetEmailResendWidget({super.key});

  @override
  State<PwResetEmailResendWidget> createState() =>
      _PwResetEmailResendWidgetState();
}

class _PwResetEmailResendWidgetState extends State<PwResetEmailResendWidget> {
  late Timer timer;
  late int remainingSeconds;

  @override
  void initState() {
    super.initState();
    remainingSeconds = KDimensions.sendingDelay;
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PwResetEmailBloc, PwResetEmailState>(
      listener: (context, state) {
        if (state.formState == PwResetEmailEnum.success) {
          if (!timer.isActive) {
            setState(() {
              remainingSeconds = KDimensions.sendingDelay;
            });
            startTimer();
          }
        }
      },
      child: remainingSeconds == 0
          ? Wrap(
              runSpacing: KPadding.kPaddingSize8,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  context.l10n.notReceiveLetter,
                  key: KWidgetkeys.screen.pwResetEmail.resendText,
                  style: AppTextStyle.materialThemeBodyMediumNeutralVariant50,
                ),
                TextButton(
                  key: KWidgetkeys.screen.pwResetEmail.resendButton,
                  onPressed: () => context.read<PwResetEmailBloc>().add(
                        const PwResetEmailEvent.sendResetCode(),
                      ),
                  style: KButtonStyles.withoutStylePadding8,
                  child: Text(
                    context.l10n.sendAgain,
                    style: AppTextStyle
                        .materialThemeBodyMediumNeutralVariant50UnderLine,
                  ),
                ),
              ],
            )
          : Padding(
              padding: const EdgeInsets.all(KPadding.kPaddingSize8),
              child: Text(
                context.l10n.resendWait(remainingSeconds),
                key: KWidgetkeys.screen.pwResetEmail.delayText,
                textAlign: TextAlign.center,
                style: AppTextStyle.materialThemeBodyMediumNeutralVariant50,
              ),
            ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
