import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:veteranam/shared/shared.dart';

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
      );
    } else {
      return DiscountsCardWidgetMob(
        discountItem: discountItem,
        isDesk: isDesk,
      );
    }
  }
}

class _DiscountsCardWidgetDesk extends StatelessWidget {
  const _DiscountsCardWidgetDesk({
    required this.discountItem,
    required this.isDesk,
  });

  final DiscountModel discountItem;
  final bool isDesk;

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
                UserPhotoWidget(
                  imageUrl: discountItem.userPhoto?.downloadURL,
                  onPressed: null,
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
                          Text(
                            key: KWidgetkeys.widget.discountCard.userName,
                            discountItem.userName ?? KAppText.veteranamName,
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
                ),
                ...List.generate(discountItem.category.length, (int index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: KPadding.kPaddingSize4,
                      horizontal: KPadding.kPaddingSize8,
                    ),
                    decoration: KWidgetTheme.boxDecorationDiscountCategory,
                    margin: const EdgeInsets.only(
                      right: KPadding.kPaddingSize4,
                    ),
                    child: Row(
                      children: [
                        KIcon.check,
                        KSizedBox.kWidthSizedBox8,
                        Text(
                          key: KWidgetkeys.widget.discountCard.category,
                          context
                                      .read<AuthenticationBloc>()
                                      .state
                                      .userSetting
                                      .locale ==
                                  Language.english
                              ? discountItem.category.elementAt(index)
                              : discountItem.categoryUA.elementAt(index),
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
                            discountItem.discount.getDiscountString(context),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _expiration(discountItem.expiration),
                    KSizedBox.kWidthSizedBox16,
                    Expanded(
                      child: CityWidgetList(
                        discountModel: discountItem,
                        isDesk: isDesk,
                      ),
                    ),
                  ],
                ),
                KSizedBox.kHeightSizedBox16,
                SharedIconListWidget(
                  text: '${discountItem.description}\n'
                      '\n${context.l10n.toGetItYouNeed}' //Title medium
                      '\n${discountItem.requirements}\n'
                      '\n${discountItem.exclusions}\n'
                      // ignore: lines_longer_than_80_chars
                      '${discountItem.additionalDetails != null ? '\n${discountItem.additionalDetails}\n' : ''}'
                      '\n${discountItem.phoneNumber}',
                  isDesk: isDesk,
                  link: discountItem.directLink ?? discountItem.link,
                  cardEnum: CardEnum.discount,
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
  });

  final DiscountModel discountItem;
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: KPadding.kPaddingSize16,
      ),
      decoration: KWidgetTheme.boxDecorationDiscountContainer,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: KPadding.kPaddingSize16,
              bottom: KPadding.kPaddingSize8,
            ),
            child: Row(
              children: [
                UserPhotoWidget(
                  imageUrl: discountItem.userPhoto?.downloadURL,
                  onPressed: null,
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
                        Wrap(
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
            padding: const EdgeInsets.symmetric(
              horizontal: KPadding.kPaddingSize16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KSizedBox.kHeightSizedBox16,
                Row(
                  children: [
                    ...List.generate(discountItem.category.length, (int index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: KPadding.kPaddingSize4,
                          horizontal: KPadding.kPaddingSize8,
                        ),
                        decoration: KWidgetTheme.boxDecorationDiscountCategory,
                        margin: const EdgeInsets.only(
                          right: KPadding.kPaddingSize4,
                        ),
                        child: Row(
                          children: [
                            KIcon.check,
                            KSizedBox.kWidthSizedBox8,
                            Text(
                              key: KWidgetkeys.widget.discountCard.category,
                              context
                                          .read<AuthenticationBloc>()
                                          .state
                                          .userSetting
                                          .locale ==
                                      Language.english
                                  ? discountItem.category.elementAt(index)
                                  : discountItem.categoryUA.elementAt(index),
                              style: AppTextStyle.materialThemeLabelLarge,
                            ),
                          ],
                        ),
                      );
                    }),
                    const Spacer(),
                    Container(
                      decoration: KWidgetTheme.boxDecorationDiscount,
                      padding: const EdgeInsets.symmetric(
                        horizontal: KPadding.kPaddingSize8,
                        vertical: KPadding.kPaddingSize4,
                      ),
                      child: TextPointWidget(
                        key: KWidgetkeys.widget.discountCard.discount,
                        hasExpanded: false,
                        discountItem.discount.getDiscountString(context),
                      ),
                    ),
                  ],
                ),
                KSizedBox.kHeightSizedBox16,
                Text(
                  discountItem.title,
                  key: KWidgetkeys.widget.discountCard.discountTitle,
                  style: AppTextStyle.materialThemeHeadlineSmall,
                  overflow: TextOverflow.clip,
                ),
                KSizedBox.kHeightSizedBox16,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _expiration(discountItem.expiration),
                    KSizedBox.kHeightSizedBox8,
                    CityWidgetList(
                      discountModel: discountItem,
                      isDesk: isDesk,
                    ),
                  ],
                ),
                KSizedBox.kHeightSizedBox16,
                Padding(
                  padding: const EdgeInsets.only(left: KPadding.kPaddingSize16),
                  child: SharedIconListWidget(
                    text: '${discountItem.description}\n'
                        '\n${context.l10n.toGetItYouNeed}' //Title medium
                        '\n${discountItem.requirements}\n'
                        '\n${discountItem.exclusions}\n'
                        // ignore: lines_longer_than_80_chars
                        '${discountItem.additionalDetails != null ? '\n${discountItem.additionalDetails}\n' : ''}'
                        '\n${discountItem.phoneNumber}',
                    isDesk: isDesk,
                    cardEnum: CardEnum.discount,
                    link: discountItem.directLink ?? discountItem.link,
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

Widget _expiration(String expiration) => Container(
      padding: const EdgeInsets.symmetric(
        vertical: KPadding.kPaddingSize8,
        horizontal: KPadding.kPaddingSize8,
      ),
      decoration: KWidgetTheme.boxDecorationDiscountContainer,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          KIcon.calendarClock,
          KSizedBox.kWidthSizedBox8,
          Text(
            expiration,
            key: KWidgetkeys.widget.discountCard.expiration,
            style: AppTextStyle.materialThemeLabelLarge,
          ),
        ],
      ),
    );
