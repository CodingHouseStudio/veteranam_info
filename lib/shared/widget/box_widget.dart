import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kozak/shared/shared.dart';

class BoxWidget extends StatelessWidget {
  const BoxWidget({required this.text, super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: KPadding.kPaddingSize8,
        right: KPadding.kPaddingSize8,
        bottom: KPadding.kPaddingSize24,
        left: KPadding.kPaddingSize24,
      ),
      decoration: KWidetTheme.boxDecorationCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconWidget(
            key: KWidgetkeys.widget.box.icon,
            icon: KIcon.arrowUpRight,
            padding: KPadding.kPaddingSize20,
          ),
          KSizedBox.kHeightSizedBox90,
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              text,
              key: KWidgetkeys.widget.box.text,
              style: AppTextStyle.text40,
            ),
          ),
        ],
      ),
    );
  }
}
