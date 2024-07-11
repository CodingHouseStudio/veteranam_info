import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class BuyMeACoffeeWidget extends StatelessWidget {
  const BuyMeACoffeeWidget({required this.isDesk, super.key});
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: null,
      style: KButtonStyles.blackButtonStyle,
      child: Padding(
        padding: isDesk
            ? const EdgeInsets.only(
                bottom: KPadding.kPaddingSize12,
                left: KPadding.kPaddingSize24,
                right: KPadding.kPaddingSize32,
                top: KPadding.kPaddingSize12,
              )
            : const EdgeInsets.only(
                bottom: KPadding.kPaddingSize8,
                left: KPadding.kPaddingSize4,
                right: KPadding.kPaddingSize8,
                top: KPadding.kPaddingSize8,
              ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            KImage.coffee(),
            if (isDesk)
              KSizedBox.kWidthSizedBox16
            else
              KSizedBox.kWidthSizedBox8,
            Flexible(
              child: Text(
                context.l10n.buyMeACoffee,
                style: isDesk
                    ? AppTextStyle.materialThemeTitleMediumNeutral
                    : AppTextStyle.materialThemeTitleSmallNeutral,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
