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
      decoration: KWidgetTheme.boxDecorationWhite.copyWith(
        border: Border.all(
          color: AppColors.materialThemeKeyColorsNeutral,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: KPadding.kPaddingSize16,
              horizontal: KPadding.kPaddingSize24,
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  child: KIcon.user,
                ),
                KSizedBox.kWidthSizedBox16,
                Column(
                  children: [
                    Text(
                      discountItem.company!,
                      style: AppTextStyle.materialThemeTitleMedium,
                    ),
                    Row(
                      children: [
                        const Text(
                          KMockText.userName,
                          style: AppTextStyle.materialThemeLabelSmall,
                        ),
                        KSizedBox.kWidthSizedBox8,
                        Text(
                          discountItem.dateVerified.toLocalDateString(),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                ChipWidget(
                  filter: discountItem.category.first,
                  isSelected: false,
                  onSelected: ({required isSelected}) => (),
                  isDesk: isDesk,
                ),
              ],
            ),
          ),
          KSizedBox.kHeightSizedBox16,
          Container(
            decoration: KWidgetTheme.boxDecorationWidget,
            padding: EdgeInsets.symmetric(
              horizontal:
                  isDesk ? KPadding.kPaddingSize48 : KPadding.kPaddingSize16,
              vertical: KPadding.kPaddingSize16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KSizedBox.kHeightSizedBox16,
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        discountItem.title,
                        key: KWidgetkeys.widget.discountCard.service,
                        style:
                            isDesk ? AppTextStyle.text40 : AppTextStyle.text18,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      discountItem.discount.toString(),
                      key: KWidgetkeys.widget.discountCard.discount,
                      style: AppTextStyle.materialThemeLabelLarge,
                    ),
                  ],
                ),
                KSizedBox.kHeightSizedBox16,
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: KPadding.kPaddingSize8,
                        horizontal: KPadding.kPaddingSize16,
                      ),
                      decoration: KWidgetTheme.boxDecorationWhite,
                      child: Row(
                        children: [
                          KIcon.calendarClock,
                          KSizedBox.kWidthSizedBox8,
                          Text(
                            discountItem.expiration,
                            style: AppTextStyle.materialThemeLabelLarge,
                          ),
                        ],
                      ),
                    ),
                    KSizedBox.kWidthSizedBox16,
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: KPadding.kPaddingSize8,
                        horizontal: KPadding.kPaddingSize16,
                      ),
                      decoration: KWidgetTheme.boxDecorationWhite,
                      child: Row(
                        children: [
                          KIcon.distance,
                          KSizedBox.kWidthSizedBox8,
                          Text(
                            discountItem.location.toString(),
                            style: AppTextStyle.materialThemeLabelLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                KSizedBox.kHeightSizedBox16,
                KSizedBox.kHeightSizedBox16,
                CardTextDetailWidget(
                  text: discountItem.description,
                  maxLines: 1,
                  icon: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        backgroundColor: AppColors.materialThemeWhite,
                        child: IconButton(
                          onPressed: null,
                          icon: KIcon.captivePortal,
                        ),
                      ),
                      KSizedBox.kWidthSizedBox24,
                      CircleAvatar(
                        backgroundColor: AppColors.materialThemeWhite,
                        child: IconButton(
                          onPressed: _discountsShareLink,
                          icon: KIcon.share,
                        ),
                      ),
                      KSizedBox.kWidthSizedBox24,
                      const CircleAvatar(
                        backgroundColor: AppColors.materialThemeWhite,
                        child: IconButton(
                          icon: KIcon.safe,
                          onPressed: null,
                        ),
                      ),
                    ],
                  ),
                  isDesk: isDesk,
                ),
                KSizedBox.kHeightSizedBox16,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _discountsShareLink() async {
    // final discountsLink = Uri.parse(
    //   discountItem.directLink,
    // );
    await Share.share(
      discountItem.directLink!,
    );
  }
}
