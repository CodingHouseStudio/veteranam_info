import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class ButtonBottomLineWidget extends StatelessWidget {
  const ButtonBottomLineWidget({
    required this.text,
    required this.onPressed,
    required this.isDesk,
    super.key,
    this.icon,
    this.width,
  });

  final String text;
  final Widget? icon;
  final void Function() onPressed;
  final double? width;
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    if (isDesk) {
      return ButtonBottomLineDeskWidget(
        text: text,
        onPressed: onPressed,
        width: width,
        icon: icon,
      );
    } else {
      return ButtonBottomLineMobileWidget(
        text: text,
        onPressed: onPressed,
        icon: icon,
      );
    }
  }
}

class ButtonBottomLineDeskWidget extends StatefulWidget {
  const ButtonBottomLineDeskWidget({
    required this.text,
    required this.onPressed,
    required this.width,
    super.key,
    this.icon,
  });

  final String text;
  final Widget? icon;
  final void Function() onPressed;
  final double? width;

  @override
  State<ButtonBottomLineDeskWidget> createState() =>
      _ButtonBottomLineDeskWidgetState();
}

class _ButtonBottomLineDeskWidgetState
    extends State<ButtonBottomLineDeskWidget> {
  late bool _isHovered;
  @override
  void initState() {
    _isHovered = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
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
            style: AppTextStyle.materialThemeTitleMedium,
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: _isHovered
                ? widget.width ??
                    (widget.text.length *
                                (AppTextStyle
                                        .materialThemeTitleMedium.fontSize! +
                                    AppTextStyle.materialThemeTitleMedium
                                        .letterSpacing!) +
                            (widget.icon != null ? KSize.kPixel8 : 0)) /
                        KSize.kPixel2
                : 0,
            height: 1,
            decoration: const BoxDecoration(color: Colors.black),
          ),
        ],
      ),
      label: widget.icon != null ? widget.icon! : const SizedBox.shrink(),
    );
  }
}

class ButtonBottomLineMobileWidget extends StatelessWidget {
  const ButtonBottomLineMobileWidget({
    required this.text,
    required this.onPressed,
    super.key,
    this.icon,
  });

  final String text;
  final Widget? icon;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      style: KButtonStyles.withoutStyle,
      icon: Text(
        text,
        style: AppTextStyle.materialThemeTitleMedium,
      ),
      label: icon != null ? icon! : const SizedBox.shrink(),
    );
  }
}
