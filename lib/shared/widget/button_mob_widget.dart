import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class ButtonMobWidget extends StatelessWidget {
  const ButtonMobWidget({required this.showGoogleIcon, super.key});

  final bool showGoogleIcon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        key: KWidgetkeys.widget.buttonMob.googleButton,
        label: const Text(
          KAppText.send,
          style: AppTextStyle.text24,
        ),
        style: KButtonStyles.secondaryButtonStyle,
        icon: showGoogleIcon ? KIcon.google : const SizedBox.shrink(),
        onPressed: () {},
      ),
    );
  }
}
