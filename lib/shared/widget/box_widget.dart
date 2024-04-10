import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class BoxWidget extends StatelessWidget {
  const BoxWidget({
    required this.text,
    required this.onIconTap,
    required this.isDesk,
    super.key,
  });
  final String text;
  final void Function() onIconTap;
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: KPadding.kPaddingSize8,
        right: KPadding.kPaddingSize8,
        bottom: isDesk ? KPadding.kPaddingSize24 : KPadding.kPaddingSize8,
        left: isDesk ? KPadding.kPaddingSize24 : KPadding.kPaddingSize16,
      ),
      decoration: KWidetTheme.boxDecorationCard,
      child: isDesk
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: onIconTap,
                  child: IconWidget(
                    key: KWidgetkeys.widget.box.icon,
                    icon: KIcon.arrowUpRight,
                    padding: KPadding.kPaddingSize20,
                  ),
                ),
                KSizedBox.kHeightSizedBox90,
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    text,
                    key: KWidgetkeys.widget.box.text,
                    style: AppTextStyle.text40,
                    maxLines: 1,
                  ),
                ),
              ],
            )
          : Row(
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
                InkWell(
                  onTap: onIconTap,
                  child: IconWidget(
                    key: KWidgetkeys.widget.box.icon,
                    icon: KIcon.arrowUpRight,
                    padding: KPadding.kPaddingSize20,
                  ),
                ),
              ],
            ),
    );
  }
}
