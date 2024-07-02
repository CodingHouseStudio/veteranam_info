import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class BoxWidget extends StatelessWidget {
  const BoxWidget({
    required this.text,
    required this.onTap,
    required this.isDesk,
    super.key,
    this.textRightPadding,
    this.textIconPaddingWidget = KSizedBox.kHeightSizedBox24,
    this.icon,
  });

  final String text;
  final void Function()? onTap;
  final bool isDesk;
  final double? textRightPadding;
  final Icon? icon;
  final Widget textIconPaddingWidget;

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
                    background: AppColors.materialThemeWhite,
                  ),
                  textIconPaddingWidget,
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(right: textRightPadding ?? 0),
                      child: Text(
                        text,
                        key: KWidgetkeys.widget.box.text,
                        style: AppTextStyle.materialThemeHeadlineSmall,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : TextButton.icon(
              onPressed: onTap,
              style: KButtonStyles.boxButtonStyle,
              icon: Expanded(
                child: Text(
                  text,
                  key: KWidgetkeys.widget.box.text,
                  style: AppTextStyle.materialThemeTitleLarge,
                  maxLines: 1,
                ),
              ),
              label: Align(
                alignment: Alignment.centerRight,
                child: IconWidget(
                  key: KWidgetkeys.widget.box.icon,
                  icon: icon ?? KIcon.arrowUpRight,
                  padding: KPadding.kPaddingSize20,
                  background: AppColors.materialThemeWhite,
                ),
              ),
            ),
    );
  }
}
