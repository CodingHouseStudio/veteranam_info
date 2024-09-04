import 'package:flutter/material.dart';

// import 'package:flutter_svg/svg.dart';

import 'package:veteranam/shared/shared.dart';

class ButtonAdditionalWidget extends StatefulWidget {
  const ButtonAdditionalWidget({
    required this.picture,
    required this.text,
    required this.isDesk,
    this.onPressed,
    this.backgroundColor,
    super.key,
  });

  final void Function()? onPressed;
  final Color? backgroundColor;
  final Widget picture;
  final String text;
  final bool isDesk;

  @override
  State<ButtonAdditionalWidget> createState() =>
      _ButtonAdditionalDeskWidgetState();
}

class _ButtonAdditionalDeskWidgetState extends State<ButtonAdditionalWidget> {
  late bool isHover;
  @override
  void initState() {
    isHover = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: KWidgetkeys.widget.buttonAdditional.desk,
      onHover: (value) => setState(() => isHover = value),
      style: KButtonStyles.additionalButtonStyle.copyWith(
        backgroundColor: WidgetStatePropertyAll(widget.backgroundColor),
        side: isHover
            ? const WidgetStatePropertyAll(BorderSide())
            : const WidgetStatePropertyAll(
                BorderSide(
                  color: AppColors.materialThemeRefSecondarySecondary70,
                ),
              ),
      ),
      onPressed: widget.onPressed,
      child: Row(
        mainAxisSize: widget.isDesk ? MainAxisSize.min : MainAxisSize.max,
        children: [
          IconWidget(
            key: KWidgetkeys.widget.buttonAdditional.icon,
            icon: widget.picture,
            padding: KPadding.kPaddingSize12,
            background: AppColors.materialThemeKeyColorsSecondary,
          ),
          if (widget.isDesk)
            Padding(
              padding: const EdgeInsets.only(
                top: KPadding.kPaddingSize12,
                bottom: KPadding.kPaddingSize12,
                left: KPadding.kPaddingSize5,
                right: KPadding.kPaddingSize16,
              ),
              child: text,
            )
          else
            Expanded(child: text),
        ],
      ),
    );
  }

  Text get text {
    return Text(
      widget.text,
      key: KWidgetkeys.widget.buttonAdditional.text,
      style: AppTextStyle.materialThemeTitleMedium,
      textAlign: TextAlign.center,
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
//       key: KWidgetkeys.widget.buttonAdditional.mob,
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
//                 key: KWidgetkeys.widget.buttonAdditional.icon,
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
//                   key: KWidgetkeys.widget.buttonAdditional.text,
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
