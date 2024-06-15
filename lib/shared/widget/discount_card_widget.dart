import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';
import 'package:share_plus/share_plus.dart';

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
      decoration: KWidgetTheme.boxDecorationWidget,
      padding: EdgeInsets.symmetric(
        horizontal: isDesk ? KPadding.kPaddingSize48 : KPadding.kPaddingSize16,
        vertical: KPadding.kPaddingSize16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                discountItem.company ?? context.l10n.companyIsHidden,
                key: KWidgetkeys.widget.discountCard.discount,
                style: isDesk ? AppTextStyle.text40 : AppTextStyle.text18,
                overflow: TextOverflow.clip,
              ),
              const Spacer(),
              Expanded(
                child: Text(
                  discountItem.title,
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
                  discountItem.dateVerified.toLocalDateString(),
                  key: KWidgetkeys.widget.discountCard.date,
                  style: AppTextStyle.hint24,
                ),
                const Spacer(),
                Text(
                  discountItem.location,
                  key: KWidgetkeys.widget.discountCard.city,
                  style: AppTextStyle.hint24,
                ),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  discountItem.dateVerified.toLocalDateString(),
                  key: KWidgetkeys.widget.discountCard.date,
                  style: AppTextStyle.hint24,
                ),
                Text(
                  discountItem.location,
                  key: KWidgetkeys.widget.discountCard.city,
                  style: AppTextStyle.hint24,
                ),
              ],
            ),
          KSizedBox.kHeightSizedBox4,
          Text(
            discountItem.description,
            key: KWidgetkeys.widget.discountCard.description,
            style: isDesk ? AppTextStyle.text24 : AppTextStyle.text14,
          ),
          KSizedBox.kHeightSizedBox4,
          Text(
            context.l10n.toGetItYouNeed,
            key: KWidgetkeys.widget.discountCard.preInstructionDiscount,
            style: isDesk ? AppTextStyle.hint24 : AppTextStyle.hint14,
          ),
          KSizedBox.kHeightSizedBox16,
          CardTextDetailWidget(
            text: discountItem.requirements,
            maxLines: 1,
            icon: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: _discountsShareLink,
                  icon: KIcon.share,
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
    );
  }

  Future<void> _discountsShareLink() async {
    // final discountsLink = Uri.parse(
    //   discountItem.directLink,
    // );
    await Share.share(
      discountItem.directLink ?? discountItem.link,
    );
  }
}
