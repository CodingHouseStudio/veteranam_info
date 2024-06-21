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
      decoration: KWidgetTheme.boxDecorationDiscount,
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
                      discountItem.company ?? context.l10n.companyIsHidden,
                      style: AppTextStyle.materialThemeTitleMedium,
                      overflow: TextOverflow.clip,
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
                          style: AppTextStyle.materialThemeLabelSmall,
                          overflow: TextOverflow.clip,
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: KPadding.kPaddingSize4,
                    horizontal: KPadding.kPaddingSize8,
                  ),
                  decoration: KWidgetTheme.boxDecorationDiscount,
                  child: Row(
                    children: [
                      KIcon.check,
                      KSizedBox.kWidthSizedBox8,
                      Expanded(
                        child: Text(
                          discountItem.category.first,
                          style: AppTextStyle.materialThemeLabelLarge,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          KSizedBox.kHeightSizedBox16,
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
                        key: KWidgetkeys.widget.discountCard.service,
                        style: AppTextStyle.materialThemeDisplaySmall,
                        overflow: TextOverflow.clip,
                      ),
                    ),
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
                      decoration: KWidgetTheme.boxDecorationDiscount,
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
                    ExpandableCityChip(
                      citiesList: discountItem,
                      isDesk: isDesk,
                    ),
                  ],
                ),
                KSizedBox.kHeightSizedBox16,
                _cardIconListWidget(
                  context,
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
      decoration: KWidgetTheme.boxDecorationDiscount.copyWith(
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
                Expanded(
                  child: ClipRect(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          discountItem.company ?? context.l10n.companyIsHidden,
                          style: AppTextStyle.materialThemeTitleSmall,
                        ),
                        Wrap(
                          children: [
                            Text(
                              discountItem.userName ?? context.l10n.anonymous,
                              style: AppTextStyle.materialThemeLabelSmall,
                            ),
                            KSizedBox.kWidthSizedBox8,
                            Text(
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
            padding: const EdgeInsets.symmetric(
              horizontal: KPadding.kPaddingSize16,
              vertical: KPadding.kPaddingSize16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KSizedBox.kHeightSizedBox16,
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            discountItem.discount.toString(),
                            key: KWidgetkeys.widget.discountCard.discount,
                            style: AppTextStyle.materialThemeLabelLarge,
                          ),
                        ),
                      ],
                    ),
                    KSizedBox.kHeightSizedBox16,
                    Text(
                      discountItem.title,
                      key: KWidgetkeys.widget.discountCard.service,
                      style: AppTextStyle.materialThemeHeadlineSmall,
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
                KSizedBox.kHeightSizedBox16,
                Padding(
                  padding:
                      const EdgeInsets.only(right: KPadding.kPaddingSize56),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: KPadding.kPaddingSize8,
                          horizontal: KPadding.kPaddingSize16,
                        ),
                        decoration: KWidgetTheme.boxDecorationDiscount,
                        child: Row(
                          children: [
                            KIcon.calendarClock,
                            KSizedBox.kWidthSizedBox8,
                            Expanded(
                              child: Text(
                                discountItem.expiration,
                                style: AppTextStyle.materialThemeLabelLarge,
                              ),
                            ),
                          ],
                        ),
                      ),
                      KSizedBox.kHeightSizedBox8,
                      ExpandableCityChip(
                        citiesList: discountItem,
                        isDesk: isDesk,
                      ),
                    ],
                  ),
                ),
                KSizedBox.kHeightSizedBox16,
                _cardIconListWidget(
                  context,
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

Widget _cardIconWidget(
  BuildContext context, {
  required VoidCallback? onPressed,
  required Icon icon,
}) {
  return CircleAvatar(
    backgroundColor: AppColors.materialThemeWhite,
    child: IconButton(
      onPressed: onPressed,
      icon: icon,
    ),
  );
}

Widget _cardIconListWidget(
  BuildContext context, {
  required String text,
  required bool isDesk,
  required VoidCallback? onPressed,
}) {
  return CardTextDetailWidget(
    text: text,
    maxLines: 1,
    icon: Wrap(
      crossAxisAlignment: WrapCrossAlignment.end,
      children: [
        _cardIconWidget(
          context,
          onPressed: null,
          icon: KIcon.captivePortal,
        ),
        KSizedBox.kWidthSizedBox24,
        _cardIconWidget(
          context,
          onPressed: onPressed,
          icon: KIcon.share,
        ),
        KSizedBox.kWidthSizedBox24,
        _cardIconWidget(
          context,
          onPressed: null,
          icon: KIcon.safe,
        ),
      ],
    ),
    isDesk: isDesk,
  );
}

class ExpandableCityChip extends StatefulWidget {
  const ExpandableCityChip({
    required this.citiesList,
    required this.isDesk,
    super.key,
  });

  final DiscountModel citiesList;
  final bool isDesk;

  @override
  State<ExpandableCityChip> createState() => _ExpandableCityChipState();
}

class _ExpandableCityChipState extends State<ExpandableCityChip> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Container(
        constraints: BoxConstraints(
          maxWidth: widget.isDesk ? KMinMaxSize.maxWidth328 : 220,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: KPadding.kPaddingSize8,
          horizontal: KPadding.kPaddingSize16,
        ),
        decoration: KWidgetTheme.boxDecorationDiscount,
        child: Expanded(
          child: Row(
            children: [
              KIcon.distance,
              KSizedBox.kWidthSizedBox8,
              Expanded(
                child: Text(
                  isExpanded
                      ? (widget.citiesList.location ?? []).join(', ')
                      : widget.citiesList.location?.firstOrNull ?? '',
                  style: AppTextStyle.materialThemeLabelLarge,
                ),
              ),
              if ((widget.citiesList.location ?? []).length > 1)
                Expanded(
                  child: Text(
                    KMockText.moreCities,
                  ),
                )
              else
                const Text(''),
            ],
          ),
        ),
      ),
    );
  }
}
