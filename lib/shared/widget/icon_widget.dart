import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({
    required this.icon,
    this.background,
    super.key,
    this.padding,
  });
  final Color? background;
  final Widget icon;
  final double? padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          KWidgetTheme.boxDecorationCircular.copyWith(color: background),
      padding: EdgeInsets.all(padding ?? KPadding.kPaddingSize20),
      child: icon,
    );
  }
}
