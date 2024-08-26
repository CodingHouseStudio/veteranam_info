import 'package:flutter/material.dart';

// import 'package:flutter_svg/svg.dart';

import 'package:veteranam/shared/constants/constants.dart';

class ButtonAdditionalWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    if (isDesk) {
      return _ButtonAdditionalDeskWidget(
        picture: picture,
        text: text,
        backgroundColor: backgroundColor,
        onPressed: onPressed,
      );
    } else {
      return _ButtonAdditionalMobWidget(
        picture: picture,
        text: text,
        backgroundColor: backgroundColor,
        onPressed: onPressed,
      );
    }
  }
}

class _ButtonAdditionalDeskWidget extends StatefulWidget {
  const _ButtonAdditionalDeskWidget({
    required this.picture,
    required this.text,
    this.onPressed,
    this.backgroundColor,
  });

  final void Function()? onPressed;
  final Color? backgroundColor;
  final Widget picture;
  final String text;

  @override
  State<_ButtonAdditionalDeskWidget> createState() =>
      _ButtonAdditionalDeskWidgetState();
}

class _ButtonAdditionalDeskWidgetState
    extends State<_ButtonAdditionalDeskWidget> {
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
      child: IntrinsicHeight(
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: CircleAvatar(
                key: KWidgetkeys.widget.buttonAdditional.icon,
                child: widget.picture,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: KPadding.kPaddingSize12,
                ),
                child: Text(
                  widget.text,
                  key: KWidgetkeys.widget.buttonAdditional.text,
                  style: AppTextStyle.materialThemeTitleLarge,
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

class _ButtonAdditionalMobWidget extends StatelessWidget {
  const _ButtonAdditionalMobWidget({
    required this.picture,
    required this.text,
    this.onPressed,
    this.backgroundColor,
  });
  final void Function()? onPressed;
  final Color? backgroundColor;
  final Widget picture;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: KWidgetkeys.widget.buttonAdditional.mob,
      style: KButtonStyles.additionalButtonStyle.copyWith(
        backgroundColor: WidgetStatePropertyAll(backgroundColor),
      ),
      onPressed: onPressed,
      child: IntrinsicHeight(
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: CircleAvatar(
                key: KWidgetkeys.widget.buttonAdditional.icon,
                child: picture,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: KPadding.kPaddingSize16,
                ),
                child: Text(
                  text,
                  key: KWidgetkeys.widget.buttonAdditional.text,
                  style: AppTextStyle.materialThemeTitleMedium,
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
