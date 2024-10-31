import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({
    required this.icon,
    this.background,
    super.key,
    this.padding,
    this.decoration,
  });
  final Color? background;
  final Widget icon;
  final double? padding;
  final Decoration? decoration;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration ??
          KWidgetTheme.boxDecorationCircular.copyWith(color: background),
      padding: EdgeInsets.all(padding ?? KPadding.kPaddingSize20),
      child: icon,
    );
  }
}
