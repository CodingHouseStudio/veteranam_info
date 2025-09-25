import 'package:flutter/material.dart';

// import 'package:flutter_svg/svg.dart';

import 'package:veteranam/shared/shared_flutter.dart';

class ButtonAdditionalWidget extends StatelessWidget {
  const ButtonAdditionalWidget({
    required this.picture,
    required this.text,
    required this.isDesk,
    required this.expanded,
    this.onPressed,
    this.backgroundColor,
    this.mobPadding,
    this.deskPadding,
    this.iconPadding,
    this.borderColor,
    this.rightWidget,
    super.key,
    this.align,
    this.hasAlign = true,
    this.textStyle,
  });

  final void Function()? onPressed;
  final Color? backgroundColor;
  final Widget picture;
  final String text;
  final bool isDesk;
  final bool expanded;
  final EdgeInsets? mobPadding;
  final EdgeInsets? deskPadding;
  final double? iconPadding;
  final Alignment? align;
  final Color? borderColor;
  final Widget? rightWidget;
  final bool hasAlign;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final button = TextButton(
      key: ButtonAdditionalKeys.desk,
      style: KButtonStyles.additionalButtonStyle.copyWith(
        maximumSize: isDesk
            ? null
            : const WidgetStatePropertyAll(
                Size(
                  KMinMaxSize.maxWidth328,
                  double.infinity,
                ),
              ),
        backgroundColor: WidgetStatePropertyAll(backgroundColor),
        side: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.hovered)
              ? const BorderSide()
              : BorderSide(
                  color: borderColor ??
                      AppColors.materialThemeRefSecondarySecondary70,
                ),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: isDesk ? MainAxisSize.min : MainAxisSize.max,
        children: [
          IconWidget(
            key: ButtonAdditionalKeys.icon,
            icon: picture,
            padding: iconPadding ?? KPadding.kPaddingSize12,
            background: AppColors.materialThemeKeyColorsSecondary,
          ),
          if (isDesk)
            if (expanded)
              Expanded(
                child: Center(child: textWidget),
              )
            else
              Padding(
                padding: deskPadding ??
                    const EdgeInsets.only(
                      top: KPadding.kPaddingSize12,
                      bottom: KPadding.kPaddingSize12,
                      left: KPadding.kPaddingSize5,
                      right: KPadding.kPaddingSize16,
                    ),
                child: textWidget,
              )
          else
            Expanded(
              child: Padding(
                padding: mobPadding ?? EdgeInsets.zero,
                child: Center(child: textWidget),
              ),
            ),
          if (rightWidget != null) rightWidget!,
        ],
      ),
    );
    if (hasAlign) {
      return Align(
        alignment: align ?? Alignment.centerLeft,
        child: button,
      );
    } else {
      return button;
    }
  }

  Text get textWidget {
    return Text(
      text,
      key: ButtonAdditionalKeys.text,
      style: textStyle ?? AppTextStyle.materialThemeTitleMedium,
      //textAlign: TextAlign.center,
    );
  }
}

// class _ButtonAdditionalMobWidget extends StatelessWidget {
//   const _ButtonAdditionalMobWidget({
//     required this.picture,
//     required this.text,
//     this.onPressed,
//     this.backgroundColor,
//   });
//   final void Function()? onPressed;
//   final Color? backgroundColor;
//   final Widget picture;
//   final String text;

//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       key: ButtonAdditionalKeys.mob,
//       style: KButtonStyles.additionalButtonStyle.copyWith(
//         backgroundColor: WidgetStatePropertyAll(backgroundColor),
//       ),
//       onPressed: onPressed,
//       child: IntrinsicHeight(
//         child: Row(
//           children: [
//             AspectRatio(
//               aspectRatio: 1,
//               child: CircleAvatar(
//                 key: ButtonAdditionalKeys.icon,
//                 child: picture,
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                   vertical: KPadding.kPaddingSize16,
//                 ),
//                 child: Text(
//                   text,
//                   key: ButtonAdditionalKeys.text,
//                   style: AppTextStyle.materialThemeTitleMedium,
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
