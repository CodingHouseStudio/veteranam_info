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
        top: KPadding.kPaddingSizeXSS,
        right: KPadding.kPaddingSizeXSS,
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
            padding: KPadding.kPaddingSizeM,
          ),
          KSizedBox.kHeightSizedBoxXXL,
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              text,
              key: KWidgetkeys.widget.box.text,
              style: AppTextStyle.lableL,
            ),
          ),
        ],
      ),
    );
  }
}
