import 'package:flutter/material.dart';

import 'package:kozak/shared/shared.dart';
import 'package:kozak/shared/widget/discount_card_icon_list_widget.dart';
import 'package:kozak/shared/widget/discounts_expandable_city_chip_widget.dart';
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
    if (isDesk) {
      return _DiscountsCardWidgetDesk(
        discountItem: discountItem,
        isDesk: isDesk,
        onPressed: _discountsShareLink,
      );
    } else {
      return DiscountsCardWidgetMob(
        discountItem: discountItem,
        isDesk: isDesk,
        onPressed: _discountsShareLink,
      );
    }
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

class _DiscountsCardWidgetDesk extends StatelessWidget {
  const _DiscountsCardWidgetDesk({
    required this.discountItem,
    required this.isDesk,
    this.onPressed,
  });

  final DiscountModel discountItem;
  final bool isDesk;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: KWidgetTheme.boxDecorationDiscountContainer,
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        key: KWidgetkeys.widget.discountCard.service,
                        discountItem.company ?? context.l10n.companyIsHidden,
                        style: AppTextStyle.materialThemeTitleMedium,
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.left,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              key: KWidgetkeys.widget.discountCard.userName,
                              KMockText.userName,
                              style: AppTextStyle.materialThemeLabelSmall,
                            ),
                          ),
                          KSizedBox.kWidthSizedBox8,
                          Expanded(
                            child: Text(
                              key: KWidgetkeys.widget.discountCard.date,
                              discountItem.dateVerified.toLocalDateString(),
                              style: AppTextStyle.materialThemeLabelSmall,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ...List.generate(discountItem.category.length, (int index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: KPadding.kPaddingSize4,
                      horizontal: KPadding.kPaddingSize8,
                    ),
                    decoration: KWidgetTheme.boxDecorationDiscountCategory,
                    child: Row(
                      children: [
                        KIcon.check,
                        KSizedBox.kWidthSizedBox8,
                        Text(
                          key: KWidgetkeys.widget.discountCard.category,
                          discountItem.category.elementAt(index),
                          style: AppTextStyle.materialThemeLabelLarge,
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
          Container(
            decoration: KWidgetTheme.boxDecorationWidget,
            padding: const EdgeInsets.symmetric(
              horizontal: KPadding.kPaddingSize32,
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
                        key: KWidgetkeys.widget.discountCard.discountTitle,
                        style: AppTextStyle.materialThemeDisplaySmall,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Container(
                      decoration: KWidgetTheme.boxDecorationDiscount,
                      padding: const EdgeInsets.symmetric(
                        horizontal: KPadding.kPaddingSize8,
                        vertical: KPadding.kPaddingSize4,
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: KPadding.kPaddingSize4,
                          ),
                          KSizedBox.kWidthSizedBox8,
                          Text(
                            '${context.l10n.discount} '
                            '${discountItem.discount.first}%',
                            key: KWidgetkeys.widget.discountCard.discount,
                            style: AppTextStyle.materialThemeLabelLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                KSizedBox.kHeightSizedBox16,
                Row(
                  children: [
                    Flexible(
                      child: IntrinsicWidth(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: KPadding.kPaddingSize8,
                            horizontal: KPadding.kPaddingSize16,
                          ),
                          decoration:
                              KWidgetTheme.boxDecorationDiscountContainer,
                          child: Row(
                            children: [
                              KIcon.calendarClock,
                              KSizedBox.kWidthSizedBox8,
                              Expanded(
                                child: Text(
                                  key: KWidgetkeys
                                      .widget.discountCard.expiration,
                                  discountItem.expiration,
                                  style: AppTextStyle.materialThemeLabelLarge,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    KSizedBox.kWidthSizedBox16,
                    ExpandableCityChip(
                      discountModel: discountItem,
                      isDesk: isDesk,
                    ),
                  ],
                ),
                KSizedBox.kHeightSizedBox16,
                DiscountCardIconListWidget(
                  text: discountItem.description,
                  isDesk: isDesk,
                  onPressed: onPressed,
                ),
                KSizedBox.kHeightSizedBox16,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DiscountsCardWidgetMob extends StatelessWidget {
  const DiscountsCardWidgetMob({
    required this.discountItem,
    required this.isDesk,
    super.key,
    this.onPressed,
  });

  final DiscountModel discountItem;
  final bool isDesk;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: KWidgetTheme.boxDecorationDiscountContainer,
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
                Expanded(
                  child: ClipRect(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          key: KWidgetkeys.widget.discountCard.service,
                          discountItem.company ?? context.l10n.companyIsHidden,
                          style: AppTextStyle.materialThemeTitleSmall,
                        ),
                        Row(
                          children: [
                            Text(
                              key: KWidgetkeys.widget.discountCard.userName,
                              discountItem.userName ?? context.l10n.anonymous,
                              style: AppTextStyle.materialThemeLabelSmall,
                            ),
                            KSizedBox.kWidthSizedBox8,
                            Text(
                              key: KWidgetkeys.widget.discountCard.date,
                              discountItem.dateVerified.toLocalDateString(),
                              style: AppTextStyle.materialThemeLabelSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: KWidgetTheme.boxDecorationWidget,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: KPadding.kPaddingSize16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KSizedBox.kHeightSizedBox16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ...List.generate(discountItem.category.length,
                          (int index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: KPadding.kPaddingSize4,
                            horizontal: KPadding.kPaddingSize8,
                          ),
                          decoration:
                              KWidgetTheme.boxDecorationDiscountCategory,
                          child: Row(
                            children: [
                              KIcon.check,
                              KSizedBox.kWidthSizedBox8,
                              Text(
                                key: KWidgetkeys.widget.discountCard.category,
                                discountItem.category.elementAt(index),
                                style: AppTextStyle.materialThemeLabelLarge,
                              ),
                            ],
                          ),
                        );
                      }),
                      Container(
                        decoration: KWidgetTheme.boxDecorationDiscount,
                        padding: const EdgeInsets.symmetric(
                          horizontal: KPadding.kPaddingSize8,
                          vertical: KPadding.kPaddingSize4,
                        ),
                        child: TextPointWidget(
                          key: KWidgetkeys.widget.discountCard.discount,
                          hasExpanded: false,
                          '${context.l10n.discount} '
                          '${discountItem.discount.first}%',
                        ),
                      ),
                    ],
                  ),
                  KSizedBox.kHeightSizedBox16,
                  Padding(
                    padding: const EdgeInsets.only(
                      left: KPadding.kPaddingSize16,
                    ),
                    child: Text(
                      discountItem.title,
                      key: KWidgetkeys.widget.discountCard.discountTitle,
                      style: AppTextStyle.materialThemeHeadlineSmall,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  KSizedBox.kHeightSizedBox16,
                  Padding(
                    padding: const EdgeInsets.only(
                      right: KPadding.kPaddingSize56,
                      left: KPadding.kPaddingSize16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          constraints: const BoxConstraints(
                            maxWidth: KMinMaxSize.maxWidth220,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: KPadding.kPaddingSize8,
                            horizontal: KPadding.kPaddingSize8,
                          ),
                          decoration:
                              KWidgetTheme.boxDecorationDiscountContainer,
                          child: Row(
                            children: [
                              KIcon.calendarClock,
                              KSizedBox.kWidthSizedBox8,
                              Expanded(
                                child: Text(
                                  key: KWidgetkeys
                                      .widget.discountCard.expiration,
                                  discountItem.expiration,
                                  style: AppTextStyle.materialThemeLabelLarge,
                                ),
                              ),
                            ],
                          ),
                        ),
                        KSizedBox.kHeightSizedBox8,
                        ExpandableCityChip(
                          discountModel: discountItem,
                          isDesk: isDesk,
                        ),
                      ],
                    ),
                  ),
                  KSizedBox.kHeightSizedBox16,
                  Padding(
                    padding:
                        const EdgeInsets.only(left: KPadding.kPaddingSize16),
                    child: DiscountCardIconListWidget(
                      text: discountItem.description,
                      isDesk: isDesk,
                      onPressed: onPressed,
                    ),
                  ),
                  KSizedBox.kHeightSizedBox16,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
