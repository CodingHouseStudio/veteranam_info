import 'package:flutter/material.dart';

// import 'package:flutter_svg/svg.dart';

import 'package:veteranam/shared/constants/constants.dart';

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
  final Widget picture;
  final String text;
  final bool isDesk;

  @override
  State<ButtonAdditionalWidget> createState() => _ButtonAdditionalWidgetState();
}

class _ButtonAdditionalWidgetState extends State<ButtonAdditionalWidget> {
  late bool isHover;
  @override
  void initState() {
    isHover = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: KWidgetkeys.widget.buttonAdditional.button,
      // coverage:ignore-start
      onHover: (value) => setState(() => isHover = value),
      // coverage:ignore-end
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
      child: IntrinsicHeight(
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: CircleAvatar(
                key: KWidgetkeys.widget.buttonAdditional.buttonIcon,
                child: widget.picture,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: widget.isDesk
                      ? KPadding.kPaddingSize12
                      : KPadding.kPaddingSize16,
                ),
                child: Text(
                  widget.text,
                  key: KWidgetkeys.widget.buttonAdditional.buttonText,
                  style: widget.isDesk
                      ? AppTextStyle.materialThemeTitleLarge
                      : AppTextStyle.materialThemeTitleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
