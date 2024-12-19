import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class CheckPointWidget extends StatelessWidget {
  const CheckPointWidget({
    required this.onChanged,
    required this.isCheck,
    required this.text,
    required this.isDesk,
    super.key,
    this.textStyle,
    this.textWidget,
    this.maxLines = 3,
    this.ammountWidget,
  });
  final void Function()? onChanged;
  final bool isCheck;
  final String? text;
  final TextStyle? textStyle;
  final bool isDesk;
  final Widget? textWidget;
  final int? maxLines;
  final Widget? ammountWidget;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TooltipWidget(
        description: text ?? '',
        duration: const Duration(milliseconds: 500),
        waitDuration: const Duration(seconds: 1),
        text: '',
        child: TextButton(
          key: KWidgetkeys.widget.checkPoint.widget,
          style: KButtonStyles.additionalButtonStyle,
          onPressed: onChanged,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              DecoratedBox(
                decoration: isCheck
                    ? KWidgetTheme.boxDecorCheckPointTrue
                    : KWidgetTheme.boxDecorCheckPointFalse,
                // padding: const EdgeInsets.only(
                //   top: KPadding.kPaddingSize4,
                //   left: KPadding.kPaddingSize8,
                //   bottom: KPadding.kPaddingSize8,
                // ),
                child: Padding(
                  key: isCheck ? KWidgetkeys.widget.checkPoint.icon : null,
                  padding: const EdgeInsets.all(
                    KPadding.kPaddingSize4,
                  ),
                  child: isCheck
                      ? KIcon.checkSmall
                      : const SizedBox(
                          width: KSize.kSmallIconSize,
                          height: KSize.kSmallIconSize,
                        ),
                ),
              ),
              KSizedBox.kWidthSizedBox16,
              Flexible(
                child: textWidget ??
                    Text(
                      text ?? '',
                      key: KWidgetkeys.widget.checkPoint.text,
                      maxLines: maxLines,
                      overflow: TextOverflow.ellipsis,
                      style: textStyle ??
                          (isDesk
                              ? AppTextStyle.materialThemeBodyLarge
                              : AppTextStyle.materialThemeBodyMedium),
                    ),
              ),
              if (ammountWidget != null) ...[
                KSizedBox.kWidthSizedBox16,
                ammountWidget!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class CheckPointAmountWidget extends StatelessWidget {
  const CheckPointAmountWidget({
    required this.isDesk,
    required this.isCheck,
    required this.filterItem,
    required this.onChanged,
    super.key,
    this.amoutActiveClor,
    this.amoutInactiveClor,
    this.maxLines = 3,
    this.textStyle,
  });
  final bool isDesk;
  final void Function()? onChanged;
  final bool isCheck;
  final FilterItem filterItem;
  final Color? amoutActiveClor;
  final Color? amoutInactiveClor;
  final int? maxLines;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return CheckPointWidget(
      onChanged: onChanged,
      isCheck: isCheck,
      text: filterItem.value.getTrsnslation(context),
      isDesk: isDesk,
      ammountWidget: AmountWidget(
        key: KWidgetkeys.widget.checkPoint.ammount,
        background: isCheck
            ? amoutActiveClor ?? AppColors.materialThemeKeyColorsSecondary
            : amoutInactiveClor ?? AppColors.materialThemeKeyColorsNeutral,
        textColor: isCheck
            ? AppColors.materialThemeKeyColorsNeutral
            : AppColors.materialThemeKeyColorsSecondary,
        number: filterItem.number,
        padding: const EdgeInsets.symmetric(
          horizontal: KPadding.kPaddingSize8,
          vertical: KPadding.kPaddingSize4,
        ),
      ),
      maxLines: maxLines,
      textStyle: textStyle,
    );
  }
}
