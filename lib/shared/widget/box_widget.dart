import 'package:flutter/material.dart';

import 'package:veteranam/shared/shared_flutter.dart';

class BoxWidget extends StatelessWidget {
  const BoxWidget({
    required this.text,
    required this.onTap,
    required this.isDesk,
    super.key,
    this.textRightPadding,
    this.useSoaccer = false,
    this.icon,
    this.iconText,
    this.iconHasBackground = true,
    this.background,
    this.textStyle,
    this.padding,
  });

  final String text;
  final String? iconText;
  final void Function()? onTap;
  final bool isDesk;
  final double? textRightPadding;
  final Icon? icon;
  final bool iconHasBackground;
  final bool useSoaccer;
  final Color? background;
  final TextStyle? textStyle;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    // decoration: KWidgetTheme.boxDecorationCard.copyWith(color: background),
    if (isDesk) {
      return TextButton(
        onPressed: onTap,
        style: background == null && padding == null
            ? KButtonStyles.boxButtonStyle
            : KButtonStyles.boxButtonStyle.copyWith(
                backgroundColor: background == null
                    ? null
                    : WidgetStatePropertyAll(background),
                padding:
                    padding == null ? null : WidgetStatePropertyAll(padding),
              ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          spacing: useSoaccer ? 0 : KPadding.kPaddingSize24,
          children: [
            if (iconText != null)
              Row(
                children: [
                  Expanded(
                    child: Text(
                      iconText!,
                      style: AppTextStyle.materialThemeBodySmall,
                    ),
                  ),
                  getIcon,
                ],
              )
            else
              getIcon,
            if (useSoaccer) const Spacer(),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(right: textRightPadding ?? 0),
                child: Text(
                  text,
                  key: BoxKeys.text,
                  style: textStyle ?? AppTextStyle.materialThemeHeadlineSmall,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return TextButton(
        onPressed: onTap,
        style: background == null
            ? KButtonStyles.boxMobButtonStyle
            : KButtonStyles.boxMobButtonStyle.copyWith(
                backgroundColor: WidgetStatePropertyAll(background),
                padding: WidgetStatePropertyAll(
                  padding ??
                      const EdgeInsets.all(
                        KPadding.kPaddingSize8,
                      ),
                ),
              ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: KPadding.kPaddingSize8,
                ),
                child: Text(
                  text,
                  key: BoxKeys.text,
                  style: textStyle ?? AppTextStyle.materialThemeTitleLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            getIcon,
          ],
        ),
      );
    }
  }

  Widget get getIcon {
    if (iconHasBackground) {
      return IconWidget(
        key: BoxKeys.icon,
        icon: icon ?? KIcon.arrowUpRight,
        padding: KPadding.kPaddingSize20,
        background: AppColors.materialThemeWhite,
      );
    } else {
      return icon ??
          KIcon.arrowUpRight.copyWith(
            key: BoxKeys.icon,
          );
    }
  }
}
