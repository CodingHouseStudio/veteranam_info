import 'package:flutter/material.dart';

class HomeScreenCard extends StatelessWidget {
  const HomeScreenCard({
    required this.rightWidget,
    required this.leftWidget,
    required this.rightPadding,
    super.key,
  });
  final Widget rightWidget;
  final Widget leftWidget;
  final double rightPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: rightPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: leftWidget),
          Expanded(
            child: rightWidget,
          ),
        ],
      ),
    );
  }
}
