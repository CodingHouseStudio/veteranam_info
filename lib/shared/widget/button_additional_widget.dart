import 'package:flutter/material.dart';
import 'package:kozak/l10n/l10n.dart';
import 'package:kozak/shared/constants/constants.dart';

class ButtonAdditionalWidget extends StatefulWidget {
  const ButtonAdditionalWidget({
    super.key,
    this.onPressed,
    this.backgroundColor,
  });

  final void Function()? onPressed;
  final Color? backgroundColor;

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
    return TextButton(
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            key: KWidgetkeys.widget.buttonAdditional.buttonIcon,
            child: KImage.google,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: KPadding.kPaddingSize8,
              right: KPadding.kPaddingSize16,
            ),
            child: Text(
              key: KWidgetkeys.widget.buttonAdditional.buttonText,
              context.l10n.google,
              style: AppTextStyle.text14,
            ),
          ),
        ],
      ),
    );
  }
}
