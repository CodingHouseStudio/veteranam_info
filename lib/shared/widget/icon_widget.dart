import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({
    required this.icon,
    this.background,
    super.key,
    this.padding,
  });
  final Color? background;
  final Icon icon;
  final double? padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: KWidetTheme.boxDecorationCircular.copyWith(color: background),
      //  BoxDecoration(
      //   shape: BoxShape.circle,
      //   color: background ?? KColorTheme.white,
      // ),
      child: Padding(
        padding: EdgeInsets.all(padding ?? KPadding.kPaddingSize12),
        child: icon,
      ),
    );
  }
}
