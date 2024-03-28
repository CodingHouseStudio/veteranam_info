import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({required this.icon, this.background, super.key});
  final Color? background;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: background ?? KColorTheme.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(KPadding.kPaddingSizeS),
        child: icon,
      ),
    );
  }
}
