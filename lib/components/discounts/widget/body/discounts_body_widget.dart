import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class DiscountsBodyWidget extends StatelessWidget {
  const DiscountsBodyWidget({
    required this.discount,
    required this.city,
    required this.service,
    required this.description,
    required this.date,
    required this.instruction,
    super.key,
  });

  final String discount;
  final String city;
  final String service;
  final String description;
  final String date;
  final String instruction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: KWidetTheme.boxDecorPrimary,
        child: Padding(
          padding: const EdgeInsets.all(KPadding.kPaddingSize10),
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
                      style: AppTextStyle.text32,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    child: Text(
                      service,
                      key: KWidgetkeys.widget.discountCard.service,
                      style: AppTextStyle.text32,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
              Text(
                city,
                key: KWidgetkeys.widget.discountCard.city,
                style: AppTextStyle.text20.copyWith(
                  color: AppColors.lightGray,
                ),
              ),
              Text(
                date,
                key: KWidgetkeys.widget.discountCard.date,
                style: AppTextStyle.text20.copyWith(
                  color: AppColors.lightGray,
                ),
              ),
              Text(
                description,
                key: KWidgetkeys.widget.discountCard.description,
                style: AppTextStyle.text16,
              ),
              KSizedBox.kHeightSizedBox16,
              CardTextDetailWidget(
                text: instruction,
                maxLines: 1,
                icon: Row(
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
    );
  }
}
