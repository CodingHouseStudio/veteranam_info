import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import 'package:kozak/shared/constants/constants.dart';

class ButtonAdditionalWidget extends StatefulWidget {
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
  State<ButtonAdditionalWidget> createState() => _ButtonAdditionalWidgetState();
}

class _ButtonAdditionalWidgetState extends State<ButtonAdditionalWidget> {
  late bool _isHovered;

  @override
  void initState() {
    _isHovered = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: KPadding.kPaddingSize56,
      child: TextButton(
        key: KWidgetkeys.widget.buttonAdditional.button,
        style:
            KButtonStyles.additionalButtonStyle(isHovered: _isHovered).copyWith(
          backgroundColor: widget.backgroundColor != null
              ? MaterialStatePropertyAll(widget.backgroundColor)
              : null,
        ),
        onPressed: widget.onPressed,
        onHover: (value) => setState(() {
          _isHovered = value;
        }),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: CircleAvatar(
                key: KWidgetkeys.widget.buttonAdditional.buttonIcon,
                child: widget.picture,
              ),
            ),
            Center(
              child: Text(
                widget.text,
                key: KWidgetkeys.widget.buttonAdditional.buttonText,
                style: widget.isDesk
                    ? AppTextStyle.materialThemeTitleLarge
                    : AppTextStyle.materialThemeTitleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
