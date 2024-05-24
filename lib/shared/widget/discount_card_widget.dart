import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class DiscountsCardWidget extends StatelessWidget {
  const DiscountsCardWidget({
    required this.discountItem,
    required this.isDesk,
    super.key,
  });

  final DiscountModel discountItem;
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: context.widgetTheme.boxDecorationWidget,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              isDesk ? KPadding.kPaddingSize48 : KPadding.kPaddingSize16,
          vertical: KPadding.kPaddingSize16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  discountItem.discount,
                  key: KWidgetkeys.widget.discountCard.discount,
                  style: isDesk ? AppTextStyle.text40 : AppTextStyle.text18,
                  overflow: TextOverflow.clip,
                ),
                const Spacer(),
                Expanded(
                  child: Text(
                    discountItem.service,
                    key: KWidgetkeys.widget.discountCard.service,
                    style: isDesk ? AppTextStyle.text40 : AppTextStyle.text18,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ],
            ),
            KSizedBox.kHeightSizedBox4,
            if (isDesk)
              Row(
                children: [
                  Text(
                    discountItem.date.toLocalDateString(),
                    key: KWidgetkeys.widget.discountCard.date,
                    style: context.textStyle.hint24,
                  ),
                  const Spacer(),
                  Text(
                    discountItem.city,
                    key: KWidgetkeys.widget.discountCard.city,
                    style: context.textStyle.hint24,
                  ),
                ],
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    discountItem.date.toLocalDateString(),
                    key: KWidgetkeys.widget.discountCard.date,
                    style: context.textStyle.hint24,
                  ),
                  Text(
                    discountItem.city,
                    key: KWidgetkeys.widget.discountCard.city,
                    style: context.textStyle.hint24,
                  ),
                ],
              ),
            KSizedBox.kHeightSizedBox4,
            Text(
              discountItem.discountDescription,
              key: KWidgetkeys.widget.discountCard.description,
              style: isDesk ? AppTextStyle.text24 : AppTextStyle.text14,
            ),
            KSizedBox.kHeightSizedBox4,
            Text(
              discountItem.preInstructionDiscount,
              key: KWidgetkeys.widget.discountCard.preInstructionDiscount,
              style:
                  isDesk ? context.textStyle.hint24 : context.textStyle.hint14,
            ),
            KSizedBox.kHeightSizedBox16,
            CardTextDetailWidget(
              text: discountItem.instruction,
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
              isDesk: isDesk,
            ),
            KSizedBox.kHeightSizedBox16,
          ],
        ),
      ),
    );
  }
}
