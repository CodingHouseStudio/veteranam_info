import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class StatisticBoxWidget extends StatelessWidget {
  const StatisticBoxWidget({
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.isDesk,
    super.key,
    this.textRightPadding,
    this.icon,
  });

  final String title;
  final String subtitle;
  final void Function()? onTap;
  final bool isDesk;
  final double? textRightPadding;
  final Icon? icon;

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
                    icon: icon ?? KIcon.arrowUpRight,
                    padding: KPadding.kPaddingSize20,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(right: textRightPadding ?? 0),
                      child: Column(
                        children: [
                          Text(
                            title,
                            key: KWidgetkeys.widget.box.text,
                            style: AppTextStyle.materialThemeHeadlineSmall,
                            maxLines: 1,
                          ),
                          Text(
                            subtitle,
                            key: KWidgetkeys.widget.box.text,
                            style: AppTextStyle.materialThemeHeadlineSmall,
                            maxLines: 1,
                          ),
                        ],
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
                  Column(
                    children: [
                      Text(
                        title,
                        key: KWidgetkeys.widget.box.text,
                        style: AppTextStyle.materialThemeTitleLarge,
                        maxLines: 1,
                      ),
                      Text(
                        subtitle,
                        key: KWidgetkeys.widget.box.text,
                        style: AppTextStyle.materialThemeTitleLarge,
                        maxLines: 1,
                      ),
                    ],
                  ),
                  IconWidget(
                    key: KWidgetkeys.widget.box.icon,
                    icon: icon ?? KIcon.arrowUpRight,
                    padding: KPadding.kPaddingSize20,
                  ),
                ],
              ),
            ),
    );
  }
}
