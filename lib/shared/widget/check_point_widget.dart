import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class CheckPointWidget extends StatelessWidget {
  const CheckPointWidget({
    required this.onChanged,
    required this.isCheck,
    required this.text,
    required this.isDesk,
    super.key,
    this.textStyle,
  });
  final void Function()? onChanged;
  final bool isCheck;
  final String text;
  final TextStyle? textStyle;
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton.icon(
        key: KWidgetkeys.widget.checkPoint.widget,
        style: KButtonStyles.additionalButtonStyle,
        onPressed: onChanged,
        icon: DecoratedBox(
          decoration: isCheck
              ? KWidgetTheme.boxDecorCheckPointTrue
              : KWidgetTheme.boxDecorCheckPointFalse,
          // padding: const EdgeInsets.only(
          //   top: KPadding.kPaddingSize4,
          //   left: KPadding.kPaddingSize8,
          //   bottom: KPadding.kPaddingSize8,
          // ),
          child: Padding(
            padding: const EdgeInsets.all(
              KPadding.kPaddingSize4,
            ),
            child: isCheck
                ? KIcon.check.copyWith(
                    key: KWidgetkeys.widget.checkPoint.icon,
                  )
                : const SizedBox(
                    width: KSize.kcheckPointIconSize,
                    height: KSize.kcheckPointIconSize,
                  ),
          ),
        ),
        label: Text(
          text,
          style: textStyle ??
              (isDesk
                  ? AppTextStyle.materialThemeBodyLarge
                  : AppTextStyle.materialThemeBodyMedium),
        ),
      ),
    );
  }
}
