import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class BoxWidget extends StatelessWidget {
  const BoxWidget({
    required this.text,
    required this.onTap,
    required this.isDesk,
    super.key,
    this.textRightPadding,
  });

  final String text;
  final void Function() onTap;
  final bool isDesk;
  final double? textRightPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: KPadding.kPaddingSize8,
        right: KPadding.kPaddingSize8,
        bottom: isDesk ? KPadding.kPaddingSize24 : KPadding.kPaddingSize8,
        left: isDesk ? KPadding.kPaddingSize24 : KPadding.kPaddingSize16,
      ),
      decoration: KWidgetTheme.boxDecorationCard,
      child: isDesk
          ? InkWell(
              onTap: onTap,
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
                    child: Padding(
                      padding: EdgeInsets.only(right: textRightPadding ?? 0),
                      child: Text(
                        text,
                        key: KWidgetkeys.widget.box.text,
                        style: AppTextStyle.text40,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : InkWell(
              onTap: onTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      text,
                      key: KWidgetkeys.widget.box.text,
                      style: AppTextStyle.text24,
                      maxLines: 1,
                    ),
                  ),
                  IconWidget(
                    key: KWidgetkeys.widget.box.icon,
                    icon: KIcon.arrowUpRight,
                    padding: KPadding.kPaddingSize20,
                  ),
                ],
              ),
            ),
    );
  }
}
