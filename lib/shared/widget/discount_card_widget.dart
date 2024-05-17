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
    return Container(
      padding: const EdgeInsets.all(KPadding.kPaddingSize16),
      decoration: context.widgetTheme.boxDecorationWidget,
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
                  style: isDesk ? AppTextStyle.text40 : AppTextStyle.text18,
                  overflow: TextOverflow.clip,
                ),
              ),
              const Spacer(),
              Expanded(
                child: Text(
                  service,
                  key: KWidgetkeys.widget.discountCard.service,
                  style: isDesk ? AppTextStyle.text40 : AppTextStyle.text18,
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
                  style: context.textStyle.hint24,
                ),
                const Spacer(),
                Text(
                  city,
                  key: KWidgetkeys.widget.discountCard.city,
                  style: context.textStyle.hint24,
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
                  style: context.textStyle.hint14,
                ),
                Text(
                  city,
                  key: KWidgetkeys.widget.discountCard.city,
                  style: context.textStyle.hint14,
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
            style: isDesk ? context.textStyle.hint24 : context.textStyle.hint14,
          ),
          KSizedBox.kHeightSizedBox16,
          CardTextDetailWidget(
            text: instruction,
            maxLines: 1,
            icon: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KIcon.share,
                KSizedBox.kWidthSizedBox16,
                KIcon.safe,
              ],
            ),
            isDesk: isDesk,
          ),
          KSizedBox.kHeightSizedBox16,
        ],
      ),
    );
  }
}
