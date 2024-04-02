import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class ButtonMobWidget extends StatelessWidget {
  const ButtonMobWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            key: KWidgetkeys.buttonMob.googleButton,
            label: const Text(
              KAppText.send,
              style: AppTextStyle.lableMediumSmall,
            ),
            style: KButtonStyles.secondaryButtonStyle,
            icon: KIcon.google,
            onPressed: () {},
          ),
          KSizedBox.kHeightSizedBoxS,
          ElevatedButton(
            key: KWidgetkeys.buttonMob.button,
            style: KButtonStyles.secondaryButtonStyle,
            onPressed: () {},
            child: const Text(
              KAppText.send,
              style: AppTextStyle.lableMediumSmall,
            ),
          ),
        ],
      ),
    );
  }
}
