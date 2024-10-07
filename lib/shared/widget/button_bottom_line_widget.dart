import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

// class ButtonBottomLineWidget extends StatelessWidget {
//   const ButtonBottomLineWidget({
//     required this.text,
//     required this.onPressed,
//     // required this.isDesk,
//     required this.widgetKey,
//     super.key,
//     this.icon,
//     this.width,
//   });

//   final String text;
//   final Widget? icon;
//   final void Function() onPressed;
//   final double? width;
//   // final bool isDesk;
//   final Key widgetKey;

//   @override
//   Widget build(BuildContext context) {
//     // if (isDesk) {
//     return ButtonBottomLineDeskWidget(
//       text: text,
//       onPressed: onPressed,
//       width: width,
//       icon: icon,
//       widgetKey: widgetKey,
//     );
//     // } else {
//     //   return ButtonBottomLineMobileWidget(
//     //     text: text,
//     //     onPressed: onPressed,
//     //     icon: icon,
//     //     widgetKey: widgetKey,
//     //   );
//     // }
//   }
// }

class ButtonBottomLineWidget extends StatefulWidget {
  const ButtonBottomLineWidget({
    required this.text,
    required this.onPressed,
    required this.widgetKey,
    // required this.width,
    super.key,
    this.icon,
  });

  final String text;
  final Widget? icon;
  final void Function() onPressed;
  final Key widgetKey;
  // final double width;

  @override
  State<ButtonBottomLineWidget> createState() => _ButtonBottomLineWidgetState();
}

class _ButtonBottomLineWidgetState extends State<ButtonBottomLineWidget> {
  late bool _isHovered;
  late double textWidth;
  @override
  void initState() {
    _isHovered = false;
    textWidth = widget.text.getTextWidth(
      textStyle: AppTextStyle.materialThemeTitleMedium,
      // width: widget.width,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      key: widget.widgetKey,
      onPressed: widget.onPressed,
      style: KButtonStyles.withoutStyle,
      onHover: (value) => setState(() => _isHovered = value),
      icon: Column(
        // mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.text,
            key: KWidgetkeys.widget.buttonBottomLine.text,
            style: AppTextStyle.materialThemeTitleMedium,
          ),
          AnimatedContainer(
            key: KWidgetkeys.widget.buttonBottomLine.line,
            duration: const Duration(milliseconds: 300),
            width: _isHovered ? textWidth : 0,
            height: 1,
            decoration: const BoxDecoration(color: Colors.black),
          ),
        ],
      ),
      label: widget.icon != null ? widget.icon! : const SizedBox.shrink(),
    );
  }
}

// class ButtonBottomLineMobileWidget extends StatelessWidget {
//   const ButtonBottomLineMobileWidget({
//     required this.text,
//     required this.onPressed,
//     required this.widgetKey,
//     super.key,
//     this.icon,
//   });

//   final String text;
//   final Widget? icon;
//   final void Function() onPressed;
//   final Key widgetKey;
//   @override
//   Widget build(BuildContext context) {
//     return TextButton.icon(
//       key: widgetKey,
//       onPressed: onPressed,
//       style: KButtonStyles.withoutStyle,
//       icon: Text(
//         text,
//         key: KWidgetkeys.widget.buttonBottomLine.text,
//         style: AppTextStyle.materialThemeTitleMedium,
//       ),
//       label: icon != null ? icon! : const SizedBox.shrink(),
//     );
//   }
// }
