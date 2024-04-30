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
      decoration: KWidgetTheme.boxDecorationCircular(context)
          .copyWith(color: background),
      child: Padding(
        padding: EdgeInsets.all(padding ?? KPadding.kPaddingSize12),
        child: icon,
      ),
    );
  }
}
