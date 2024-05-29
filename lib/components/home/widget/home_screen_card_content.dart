import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class HomeScreenCardContent extends StatelessWidget {
  const HomeScreenCardContent({
    required this.isDesk,
    required this.textPoint,
    required this.title,
    required this.subtitle,
    required this.textButton,
    required this.padding,
    required this.route,
    required this.bottomWidget,
    super.key,
  });
  final bool isDesk;
  final String textPoint;
  final String title;
  final String subtitle;
  final String textButton;
  final EdgeInsets padding;
  final void Function()? route;
  final Widget bottomWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        children: [
          TextPointWidget(textPoint),
          KSizedBox.kHeightSizedBox16,
          Text(
            title,
            style: AppTextStyle.materialThemeDisplayLarge,
          ),
          KSizedBox.kHeightSizedBox16,
          Text(
            subtitle,
            style: AppTextStyle.materialThemeBodyLarge,
          ),
          KSizedBox.kHeightSizedBox16,
          DoubleButtonWidget(
            text: textButton,
            onPressed: route,
          ),
          bottomWidget,
        ],
      ),
    );
  }
}
