import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class WorkCardWidget extends StatelessWidget {
  const WorkCardWidget({
    required this.title,
    required this.city,
    required this.price,
    required this.description,
    required this.employer,
    super.key,
  });
  final String title;
  final String price;
  final String city;
  final String description;
  final String employer;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: KWidetTheme.boxDecorationWidget,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final isDesk =
              KPlatformConstants.changeToDescWidget(constraints.maxWidth);
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal:
                  isDesk ? KPadding.kPaddingSize48 : KPadding.kPaddingSize16,
              vertical: KPadding.kPaddingSize16,
            ),
            child: Column(
              crossAxisAlignment: isDesk
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.stretch,
              children: [
                Text(
                  title,
                  key: KWidgetkeys.widget.workCard.title,
                  style: AppTextStyle.text40,
                ),
                Text(
                  price,
                  key: KWidgetkeys.widget.workCard.price,
                  style: AppTextStyle.text40,
                ),
                Text(
                  city,
                  key: KWidgetkeys.widget.workCard.city,
                  style: AppTextStyle.text20.copyWith(
                    color: AppColors.lightGray,
                  ),
                ),
                Text(
                  employer,
                  key: KWidgetkeys.widget.workCard.employer,
                  style: AppTextStyle.text20.copyWith(
                    color: AppColors.lightGray,
                  ),
                ),
                KSizedBox.kHeightSizedBox16,
                CardTextDetailWidget(
                  text: description,
                  maxLines: 3,
                  icon: Row(
                    children: [
                      KIcon.share
                          .setIconKey(KWidgetkeys.widget.workCard.iconShare),
                      KSizedBox.kWidthSizedBox16,
                      KIcon.safe
                          .setIconKey(KWidgetkeys.widget.workCard.iconSafe),
                    ],
                  ),
                ),
                KSizedBox.kHeightSizedBox16,
                TextButton(
                  key: KWidgetkeys.widget.workCard.button,
                  style: KButtonStyles.lightGrayButtonStyle,
                  onPressed: null,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: isDesk
                          ? KPadding.kPaddingSize32
                          : KPadding.kPaddingSize16,
                      horizontal: KPadding.kPaddingSize80,
                    ),
                    child: Text(
                      context.l10n.respond,
                      style: AppTextStyle.text32,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
