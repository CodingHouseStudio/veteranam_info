import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import 'package:kozak/shared/constants/constants.dart';

class ButtonAdditionalWidget extends StatelessWidget {
  const ButtonAdditionalWidget({
    required this.picture,
    required this.text,
    required this.isDesk,
    super.key,
    this.onPressed,
    this.backgroundColor,
  });

  final void Function()? onPressed;
  final Color? backgroundColor;
  final SvgPicture picture;
  final String text;
  final bool isDesk;

  @override
  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: KWidgetkeys.widget.buttonAdditional.button,
      style: KButtonStyles.additionalButtonStyle.copyWith(
        backgroundColor: backgroundColor != null
            ? MaterialStatePropertyAll(backgroundColor)
            : null,
      ),
      onPressed: onPressed,
      child: IntrinsicHeight(
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: CircleAvatar(
                key: KWidgetkeys.widget.buttonAdditional.buttonIcon,
                child: picture,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: isDesk
                      ? KPadding.kPaddingSize12
                      : KPadding.kPaddingSize16,
                ),
                child: Text(
                  text,
                  key: KWidgetkeys.widget.buttonAdditional.buttonText,
                  style: isDesk
                      ? AppTextStyle.materialThemeTitleLarge
                      : AppTextStyle.materialThemeTitleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
