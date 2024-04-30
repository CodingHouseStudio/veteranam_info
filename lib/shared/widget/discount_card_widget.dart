import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class DiscountsCardWidget extends StatelessWidget {
  const DiscountsCardWidget({
    required this.discount,
    required this.city,
    required this.service,
    required this.description,
    required this.date,
    required this.isDesk,
    required this.instruction,
    required this.preInstructionDiscount,
    super.key,
  });

  final String discount;
  final String city;
  final String service;
  final String description;
  final String date;
  final String instruction;
  final String preInstructionDiscount;
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isDesk ? KPadding.kPaddingSize75 : 0,
        ),
        child: Container(
          decoration: KWidgetTheme.boxDecorationWidget(context),
          child: Padding(
            padding: const EdgeInsets.all(KPadding.kPaddingSize16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        discount,
                        key: KWidgetkeys.widget.discountCard.discount,
                        style:
                            isDesk ? AppTextStyle.text40 : AppTextStyle.text18,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      child: Text(
                        service,
                        key: KWidgetkeys.widget.discountCard.service,
                        style:
                            isDesk ? AppTextStyle.text40 : AppTextStyle.text18,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
                if (isDesk)
                  Row(
                    children: [
                      Text(
                        date,
                        key: KWidgetkeys.widget.discountCard.date,
                        style: AppTextStyle.hint24,
                      ),
                      const Spacer(),
                      Text(
                        city,
                        key: KWidgetkeys.widget.discountCard.city,
                        style: AppTextStyle.hint24,
                      ),
                    ],
                  ),
                if (!isDesk)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        date,
                        key: KWidgetkeys.widget.discountCard.date,
                        style: AppTextStyle.hint14,
                      ),
                      Text(
                        city,
                        key: KWidgetkeys.widget.discountCard.city,
                        style: AppTextStyle.hint14,
                      ),
                    ],
                  ),
                Text(
                  description,
                  key: KWidgetkeys.widget.discountCard.description,
                  style: isDesk ? AppTextStyle.text24 : AppTextStyle.text14,
                ),
                Text(
                  preInstructionDiscount,
                  key: KWidgetkeys.widget.discountCard.preInstructionDiscount,
                  style: isDesk ? AppTextStyle.hint24 : AppTextStyle.hint14,
                ),
                KSizedBox.kHeightSizedBox16,
                CardTextDetailWidget(
                  text: instruction,
                  maxLines: 1,
                  icon: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: KIcon.share,
                      ),
                      KSizedBox.kWidthSizedBox16,
                      Container(
                        child: KIcon.safe,
                      ),
                    ],
                  ),
                ),
                KSizedBox.kHeightSizedBox16,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
