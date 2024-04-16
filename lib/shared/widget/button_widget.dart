import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    required this.text,
    required this.onPressed,
    super.key,
    this.icon,
    this.textStyle,
    this.isDesk,
    this.backgroundColor,
  });
  final Widget? icon;
  final TextStyle? textStyle;
  final String text;
  final void Function()? onPressed;
  final bool? isDesk;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return isDesk == null
        ? LayoutBuilder(
            builder: (context, constraints) {
              final isDesk =
                  KPlatformConstants.changeToDescWidget(constraints.maxWidth);
              return builButton(isDesk: isDesk);
            },
          )
        : builButton(isDesk: isDesk!);
  }

  Widget builButton({required bool isDesk}) {
    return TextButton(
      onPressed: onPressed,
      style: isDesk
          ? KButtonStyles.lightGrayButtonStyle.copyWith(
              backgroundColor: MaterialStatePropertyAll(
                backgroundColor ?? AppColors.lightGray,
              ),
            )
          : KButtonStyles.lightGrayButtonStyleWInf.copyWith(
              backgroundColor: MaterialStatePropertyAll(
                backgroundColor ?? AppColors.lightGray,
              ),
            ),
      child: Padding(
        padding: isDesk
            ? const EdgeInsets.symmetric(
                horizontal: KPadding.kPaddingSize80,
                vertical: KPadding.kPaddingSize32,
              )
            : const EdgeInsets.symmetric(
                vertical: KPadding.kPaddingSize16,
              ),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            if (icon != null) icon!,
            KSizedBox.kWidthSizedBox16,
            Text(
              text,
              style: textStyle ??
                  (isDesk ? AppTextStyle.text32 : AppTextStyle.text24),
            ),
          ],
        ),
      ),
    );
  }
}
