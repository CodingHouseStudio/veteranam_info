import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class BuyMeACoffeeWidget extends StatelessWidget {
  const BuyMeACoffeeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: null,
      style: KButtonStyles.blackButtonStyle,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: KPadding.kPaddingSize12,
          left: KPadding.kPaddingSize24,
          right: KPadding.kPaddingSize32,
          top: KPadding.kPaddingSize12,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            KImage.coffee(),
            KSizedBox.kWidthSizedBox16,
            Flexible(
              child: Text(
                context.l10n.coffee,
                style: AppTextStyle.materialThemeTitleMediumNeutral,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
