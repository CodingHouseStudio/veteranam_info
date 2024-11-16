import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class BoxWidget extends StatelessWidget {
  const BoxWidget({
    required this.text,
    required this.onTap,
    required this.isDesk,
    super.key,
    this.textRightPadding,
    this.textIconPaddingWidget,
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
  final Widget? textIconPaddingWidget;
  final Color? background;
  final TextStyle? textStyle;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    // decoration: KWidgetTheme.boxDecorationCard.copyWith(color: background),
    if (isDesk) {
      return TextButton(
        onPressed: onTap,
        style: KButtonStyles.boxButtonStyle.copyWith(
          backgroundColor:
              background == null ? null : WidgetStatePropertyAll(background),
        ),
        clipBehavior: Clip.hardEdge,
        child: Padding(
          padding: padding ??
              const EdgeInsets.only(
                top: KPadding.kPaddingSize16,
                right: KPadding.kPaddingSize24,
                bottom: KPadding.kPaddingSize24,
                left: KPadding.kPaddingSize24,
              ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
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
              textIconPaddingWidget ?? KSizedBox.kHeightSizedBox24,
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.only(right: textRightPadding ?? 0),
                  child: Text(
                    text,
                    key: KWidgetkeys.widget.box.text,
                    style: textStyle ?? AppTextStyle.materialThemeHeadlineSmall,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return TextButton.icon(
        onPressed: onTap,
        style: KButtonStyles.boxMobButtonStyle.copyWith(
          backgroundColor:
              background == null ? null : WidgetStatePropertyAll(background),
        ),
        icon: Padding(
          padding: EdgeInsets.only(
            left: padding?.left ?? KPadding.kPaddingSize16,
          ),
          child: Expanded(
            child: Text(
              text,
              key: KWidgetkeys.widget.box.text,
              style: textStyle ?? AppTextStyle.materialThemeTitleLarge,
              maxLines: 1,
            ),
          ),
        ),
        label: Padding(
          padding: padding ??
              const EdgeInsets.all(
                KPadding.kPaddingSize8,
              ),
          child: Align(
            alignment: Alignment.centerRight,
            child: getIcon,
          ),
        ),
      );
    }
  }

  Widget get getIcon {
    if (iconHasBackground) {
      return IconWidget(
        key: KWidgetkeys.widget.box.icon,
        icon: icon ?? KIcon.arrowUpRight,
        padding: KPadding.kPaddingSize20,
        background: AppColors.materialThemeWhite,
      );
    } else {
      return icon ??
          KIcon.arrowUpRight.copyWith(
            key: KWidgetkeys.widget.box.icon,
          );
    }
  }
}
