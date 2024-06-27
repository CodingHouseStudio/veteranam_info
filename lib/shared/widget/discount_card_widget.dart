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
                Column(
                  children: [
                    Text(
                      key: KWidgetkeys.widget.discountCard.discount,
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
                          key: KWidgetkeys.widget.discountCard.date,
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
                  decoration: KWidgetTheme.boxDecorationDiscountCategory,
                  child: Row(
                    children: [
                      KIcon.check,
                      KSizedBox.kWidthSizedBox8,
                      Text(
                        discountItem.category.first,
                        style: AppTextStyle.materialThemeLabelLarge,
                      ),
                    ],
                  ),
                ),
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
                        key: KWidgetkeys.widget.discountCard.service,
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
                            // ignore: lines_longer_than_80_chars
                            '${context.l10n.discount} ${discountItem.discount.first}%',
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
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: KPadding.kPaddingSize8,
                        horizontal: KPadding.kPaddingSize16,
                      ),
                      decoration: KWidgetTheme.boxDecorationDiscountContainer,
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
                      discountModel: discountItem,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KSizedBox.kHeightSizedBox16,
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: KPadding.kPaddingSize16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
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
                              discountItem.category.first,
                              style: AppTextStyle.materialThemeLabelLarge,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: KWidgetTheme.boxDecorationDiscount,
                        padding: const EdgeInsets.symmetric(
                          horizontal: KPadding.kPaddingSize8,
                          vertical: KPadding.kPaddingSize4,
                        ),
                        child: TextPointWidget(
                          hasExpanded: false,
                          '${context.l10n.discount} '
                          '${discountItem.discount.first}%',
                        ),
                      ),
                    ],
                  ),
                ),
                KSizedBox.kHeightSizedBox16,
                Padding(
                  padding: const EdgeInsets.only(
                    left: KPadding.kPaddingSize16,
                  ),
                  child: Text(
                    discountItem.title,
                    key: KWidgetkeys.widget.discountCard.service,
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
                        decoration: KWidgetTheme.boxDecorationDiscountContainer,
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
                        discountModel: discountItem,
                        isDesk: isDesk,
                      ),
                    ],
                  ),
                ),
                KSizedBox.kHeightSizedBox16,
                Padding(
                  padding: const EdgeInsets.only(left: KPadding.kPaddingSize16),
                  child: _cardIconListWidget(
                    context,
                    text: discountItem.description,
                    isDesk: isDesk,
                    onPressed: onPressed,
                  ),
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
  required String label,
}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(KPadding.kPaddingSize12),
        child: IconButton(
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              AppColors.materialThemeWhite,
            ),
          ),
          onPressed: onPressed,
          icon: icon,
        ),
      ),
      Text(
        key: KWidgetkeys.widget.discountCard.description,
        label,
        style: AppTextStyle.materialThemeLabelSmall.copyWith(
          color: AppColors.materialThemeBlack,
        ),
      ),
    ],
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
    icon: [
      _cardIconWidget(
        label: context.l10n.webSite,
        context,
        onPressed: null,
        icon: KIcon.captivePortal,
      ),
      if (isDesk) KSizedBox.kWidthSizedBox24 else KSizedBox.kWidthSizedBox8,
      _cardIconWidget(
        label: context.l10n.share,
        context,
        onPressed: onPressed,
        icon: KIcon.share,
      ),
      if (isDesk) KSizedBox.kWidthSizedBox24 else KSizedBox.kWidthSizedBox8,
      _cardIconWidget(
        label: context.l10n.report,
        context,
        onPressed: null,
        icon: KIcon.report.copyWith(
          color: AppColors.materialThemeRefErrorError60,
        ),
      ),
    ],
    isDesk: isDesk,
  );
}

class ExpandableCityChip extends StatefulWidget {
  const ExpandableCityChip({
    required this.discountModel,
    required this.isDesk,
    super.key,
  });

  final DiscountModel discountModel;
  final bool isDesk;

  @override
  State<ExpandableCityChip> createState() => _ExpandableCityChipState();
}

class _ExpandableCityChipState extends State<ExpandableCityChip> {
  bool isExpanded = false;

  late final moreCities =
      'Ще ${(widget.discountModel.location ?? []).length - 1} міст...';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: KMinMaxSize.maxWidth328,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: KPadding.kPaddingSize10,
          horizontal: KPadding.kPaddingSize16,
        ),
        decoration: KWidgetTheme.boxDecorationDiscountContainer,
        child: Wrap(
          children: [
            KIcon.distance,
            if (widget.discountModel.location?.isEmpty ?? true)
              Text(
                widget.discountModel.subLocation.getList(context).first,
                style: AppTextStyle.materialThemeLabelLarge,
              ),
            if (widget.discountModel.location?.isNotEmpty ?? false)
              Text(
                widget.discountModel.location!.first +
                    (isExpanded ? ' | ' : ''),
                style: AppTextStyle.materialThemeLabelLarge,
              ),
            if (isExpanded)
              ...(widget.discountModel.location?.skip(1) ?? []).map(
                (location) => Text(
                  '$location | ',
                  style: AppTextStyle.materialThemeLabelLarge,
                ),
              ),
            KSizedBox.kWidthSizedBox8,
            if ((widget.discountModel.location ?? []).length > 1)
              if (widget.isDesk)
                Padding(
                  padding: const EdgeInsets.only(
                    left: KPadding.kPaddingSize8,
                  ),
                  child: Text(
                    isExpanded ? context.l10n.hideExpansion : moreCities,
                    style: AppTextStyle.materialThemeLabelLarge.copyWith(
                      decoration: TextDecoration.underline,
                      color: AppColors.materialThemeRefTertiaryTertiary40,
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
