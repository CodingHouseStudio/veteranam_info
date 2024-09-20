import 'package:flutter/material.dart';

import 'package:veteranam/shared/shared.dart';

class DiscountCardWidget extends StatelessWidget {
  const DiscountCardWidget({
    required this.discountItem,
    required this.isDesk,
    // required this.reportEvent,
    required this.share,
    required this.isLoading,
    super.key,
    this.closeWidget,
    this.descriptionMethod,
  });

  final DiscountModel discountItem;
  final bool isDesk;
  // final void Function()? reportEvent;
  final Widget? closeWidget;
  final String? share;
  final bool isLoading;
  final String Function(String)? descriptionMethod;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey(discountItem.id),
      decoration: KWidgetTheme.boxDecorationDiscountContainer,
      padding: const EdgeInsets.only(
        top: KPadding.kPaddingSize16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(
              right: isDesk ? KPadding.kPaddingSize28 : KPadding.kPaddingSize16,
              left: isDesk ? KPadding.kPaddingSize28 : KPadding.kPaddingSize16,
              bottom: isDesk ? KPadding.kPaddingSize16 : KPadding.kPaddingSize8,
            ),
            child: Row(
              children: [
                UserPhotoWidget(
                  imageUrl: discountItem.userPhoto?.downloadURL,
                  onPressed: null,
                  imageName: discountItem.userPhoto?.name,
                ),
                KSizedBox.kWidthSizedBox16,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        key: KWidgetkeys.widget.discountCard.service,
                        discountItem.company.getTrnslation(
                              context: context,
                              en: discountItem.companyEN,
                            ) ??
                            context.l10n.companyIsHidden,
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
                            discountItem.dateVerified
                                .toLocalDateString(context),
                            style: AppTextStyle.materialThemeLabelSmall,
                            overflow: TextOverflow.clip,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (isDesk) ..._category(context),
              ],
            ),
          ),
          // if (isDesk)
          //   KSizedBox.kHeightSizedBox16
          // else
          //   KSizedBox.kHeightSizedBox8,
          Container(
            decoration: KWidgetTheme.boxDecorationWidget,
            padding: EdgeInsets.symmetric(
              horizontal:
                  isDesk ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KSizedBox.kHeightSizedBox16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (isDesk)
                      Expanded(
                        child: Text(
                          title(context),
                          key: KWidgetkeys.widget.discountCard.discountTitle,
                          style: AppTextStyle.materialThemeDisplaySmall,
                          overflow: TextOverflow.clip,
                        ),
                      )
                    else
                      ..._category(context),
                    Container(
                      decoration: KWidgetTheme.boxDecorationDiscount,
                      padding: const EdgeInsets.symmetric(
                        horizontal: KPadding.kPaddingSize8,
                        vertical: KPadding.kPaddingSize4,
                      ),
                      child: TextPointWidget(
                        discountItem.discount.getDiscountString(context),
                        key: KWidgetkeys.widget.discountCard.discount,
                        // hasExpanded: false,
                      ),
                    ),
                  ],
                ),
                if (!isDesk) ...[
                  KSizedBox.kHeightSizedBox16,
                  Text(
                    title(context),
                    key: KWidgetkeys.widget.discountCard.discountTitle,
                    style: AppTextStyle.materialThemeHeadlineSmall,
                    overflow: TextOverflow.clip,
                  ),
                ],
                KSizedBox.kHeightSizedBox16,
                if (isDesk)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _expiration(
                        context: context,
                        expiration: discountItem.expiration.getTrnslation(
                          en: discountItem.expirationEN,
                          context: context,
                        ),
                      ),
                      KSizedBox.kWidthSizedBox16,
                      Expanded(
                        child: CityListWidget(
                          key: KWidgetkeys.widget.discountCard.city,
                          discountModel: discountItem,
                          isDesk: true,
                        ),
                      ),
                    ],
                  )
                else ...[
                  _expiration(
                    context: context,
                    expiration: discountItem.expiration.getTrnslation(
                      en: discountItem.expirationEN,
                      context: context,
                    ),
                  ),
                  KSizedBox.kHeightSizedBox8,
                  CityListWidget(
                    key: KWidgetkeys.widget.discountCard.city,
                    discountModel: discountItem,
                    isDesk: false,
                  ),
                ],
                KSizedBox.kHeightSizedBox16,
                CardTextDetailWidget(
                  key: KWidgetkeys.widget.discountCard.description,
                  text: descriptionMethod == null
                      ? discountItem.getDescription(context)
                      : descriptionMethod!(
                          discountItem.getDescription(context),
                        ),
                  hasMarkdown: !isLoading,
                  isDesk: isDesk,
                  icon: SharedIconListWidget.get(
                    context: context,
                    isDesk: isDesk,
                    link: discountItem.directLink ?? discountItem.link,
                    cardEnum: CardEnum.discount,
                    // afterEvent: reportEvent,
                    cardId: discountItem.id,
                    share: share,
                    complaintKey: KWidgetkeys.widget.discountCard.iconComplaint,
                    shareKey: KWidgetkeys.widget.discountCard.iconShare,
                    webSiteKey: KWidgetkeys.widget.discountCard.iconWebsite,
                  ),
                ),
                KSizedBox.kHeightSizedBox16,
                if (closeWidget != null) ...[
                  closeWidget!,
                  KSizedBox.kHeightSizedBox16,
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String title(BuildContext context) => discountItem.title
      .getTrnslation(en: discountItem.titleEN, context: context);

  List<Widget> _category(BuildContext context) =>
      List.generate(discountItem.category.length, (int index) {
        return Container(
          constraints: const BoxConstraints(minHeight: KMinMaxSize.minHeight30),
          padding: const EdgeInsets.symmetric(
            //vertical: KPadding.kPaddingSize4,
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
              Padding(
                padding: const EdgeInsets.only(
                  right: KPadding.kPaddingSize5,
                ),
                child: Text(
                  key: KWidgetkeys.widget.discountCard.category,
                  discountItem.category
                      .getTrnslation(
                        en: discountItem.categoryEN,
                        context: context,
                      )
                      .elementAt(index),
                  style: AppTextStyle.materialThemeLabelLarge,
                ),
              ),
            ],
          ),
        );
      });
  Widget _expiration({
    required String? expiration,
    required BuildContext context,
  }) =>
      Container(
        constraints: const BoxConstraints(minHeight: KMinMaxSize.minHeight30),
        padding: const EdgeInsets.symmetric(
          vertical: KPadding.kPaddingSize4,
          horizontal: KPadding.kPaddingSize8,
        ),
        decoration: KWidgetTheme.boxDecorationDiscountContainer,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            KIcon.calendarClock,
            KSizedBox.kWidthSizedBox8,
            Padding(
              padding: const EdgeInsets.only(
                right: KPadding.kPaddingSize4,
              ),
              child: Text(
                expiration ?? context.l10n.itIsValidAllTime,
                key: KWidgetkeys.widget.discountCard.expiration,
                style: AppTextStyle.materialThemeLabelLarge,
              ),
            ),
          ],
        ),
      );
}

// class _DiscountsCardWidgetMob extends StatelessWidget {
//   const _DiscountsCardWidgetMob({
//     required this.discountItem,
//     required this.isDesk,
//     required this.reportEvent,
//   });
//   final DiscountModel discountItem;
//   final bool isDesk;
//   final void Function()? reportEvent;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(
//         vertical: KPadding.kPaddingSize16,
//       ),
//       decoration: KWidgetTheme.boxDecorationDiscountContainer,
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(
//               left: KPadding.kPaddingSize16,
//               bottom: KPadding.kPaddingSize8,
//             ),
//             child: Row(
//               children: [
//                 UserPhotoWidget(
//                   imageUrl: discountItem.userPhoto?.downloadURL,
//                   onPressed: null,
//                 ),
//                 KSizedBox.kWidthSizedBox16,
//                 Expanded(
//                   child: ClipRect(
//                     clipBehavior: Clip.antiAlias,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Text(
//                           key: KWidgetkeys.widget.discountCard.service,
//                           discountItem.company ??
// context.l10n.companyIsHidden,
//                           style: AppTextStyle.materialThemeTitleSmall,
//                         ),
//                         Wrap(
//                           children: [
//                             Text(
//                               key: KWidgetkeys.widget.discountCard.userName,
//                               discountItem.userName ??
// context.l10n.anonymous,
//                               style: AppTextStyle.materialThemeLabelSmall,
//                             ),
//                             KSizedBox.kWidthSizedBox8,
//                             Text(
//                               key: KWidgetkeys.widget.discountCard.date,
//                               discountItem.dateVerified.toLocalDateString(),
//                               style: AppTextStyle.materialThemeLabelSmall,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             decoration: KWidgetTheme.boxDecorationWidget,
//             padding: const EdgeInsets.symmetric(
//               horizontal: KPadding.kPaddingSize16,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 KSizedBox.kHeightSizedBox16,
//                 Row(
//                   children: [
//                     ...List.generate(discountItem.category.length,
// (int index) {
//                       return Container(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: KPadding.kPaddingSize4,
//                           horizontal: KPadding.kPaddingSize8,
//                         ),
//                         decoration:
// KWidgetTheme.boxDecorationDiscountCategory,
//                         margin: const EdgeInsets.only(
//                           right: KPadding.kPaddingSize4,
//                         ),
//                         child: Row(
//                           children: [
//                             KIcon.check,
//                             KSizedBox.kWidthSizedBox8,
//                             Text(
//                               key: KWidgetkeys.widget.discountCard.category,
//                               context
//                                           .read<AuthenticationBloc>()
//                                           .state
//                                           .userSetting
//                                           .locale ==
//                                       Language.english
//                                   ? discountItem.category.elementAt(index)
//                                   : discountItem.categoryUA.elementAt(index),
//                               style: AppTextStyle.materialThemeLabelLarge,
//                             ),
//                           ],
//                         ),
//                       );
//                     }),
//                     const Spacer(),
//                     Container(
//                       decoration: KWidgetTheme.boxDecorationDiscount,
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: KPadding.kPaddingSize8,
//                         vertical: KPadding.kPaddingSize4,
//                       ),
//                       child: TextPointWidget(
//                         discountItem.discount.getDiscountString(context),
//                         key: KWidgetkeys.widget.discountCard.discount,
//                         hasExpanded: false,
//                       ),
//                     ),
//                   ],
//                 ),
//                 KSizedBox.kHeightSizedBox16,
//                 Text(
//                   discountItem.title,
//                   key: KWidgetkeys.widget.discountCard.discountTitle,
//                   style: AppTextStyle.materialThemeHeadlineSmall,
//                   overflow: TextOverflow.clip,
//                 ),
//                 KSizedBox.kHeightSizedBox16,
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _expiration(discountItem.expiration),
//                     KSizedBox.kHeightSizedBox8,
//                     CityWidgetList(
//                       discountModel: discountItem,
//                       isDesk: isDesk,
//                     ),
//                   ],
//                 ),
//                 KSizedBox.kHeightSizedBox16,
//                 Padding(
//                   padding: const EdgeInsets.only(left:
// KPadding.kPaddingSize16),
//                   child: _sharedIconListWidget(
//                     discountItem: discountItem,
//                     context: context,
//                     isDesk: false,
//                     reportEvent: reportEvent,
//                   ),
//                 ),
//                 KSizedBox.kHeightSizedBox16,
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
