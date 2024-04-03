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
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: KPadding.kPaddingSizeXL,
        vertical: KPadding.kPaddingSizeSM,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            key: KWidgetkeys.widget.workCard.title,
            style: AppTextStyle.lableL,
          ),
          Text(
            price,
            key: KWidgetkeys.widget.workCard.price,
            style: AppTextStyle.lableL,
          ),
          Text(
            city,
            key: KWidgetkeys.widget.workCard.city,
            style: AppTextStyle.lableSM.copyWith(
              color: AppColors.lightGray,
            ),
          ),
          Text(
            employer,
            key: KWidgetkeys.widget.workCard.employer,
            style: AppTextStyle.lableSM.copyWith(
              color: AppColors.lightGray,
            ),
          ),
          KSizedBox.kHeightSizedBox16,
          CardTextDetailWidget(
            text: description,
            maxLines: 3,
            icon: Row(
              children: [
                Container(
                  key: KWidgetkeys.widget.workCard.iconShare,
                  child: KIcon.share,
                ),
                KSizedBox.kWidthSizedBox16,
                Container(
                  key: KWidgetkeys.widget.workCard.iconSafe,
                  child: KIcon.safe,
                ),
              ],
            ),
          ),
          KSizedBox.kHeightSizedBox16,
          TextButton(
            key: KWidgetkeys.widget.workCard.button,
            style: KButtonStyles.lightGrayButtonStyle,
            onPressed: null,
            child: const Padding(
              padding: EdgeInsets.symmetric(
                vertical: KPadding.kPaddingSizeML,
                horizontal: KPadding.kPaddingSize80,
              ),
              child: Text(
                KAppText.workRespondButton,
                style: AppTextStyle.lableML,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
