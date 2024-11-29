import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountCardWidget extends StatelessWidget {
  const DiscountCardWidget({
    required this.discountItem,
    required this.isDesk,
    // required this.reportEvent,
    required this.share,
    super.key,
    this.closeWidget,
    this.descriptionMethod,
    this.isBusiness = false,
    this.useSiteUrl,
  });

  final DiscountModel discountItem;
  final bool isDesk;
  // final void Function()? reportEvent;
  final Widget? closeWidget;
  final String? share;
  final String Function(String)? descriptionMethod;
  final bool isBusiness;
  final bool? useSiteUrl;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      key: ValueKey(discountItem.id),
      decoration: KWidgetTheme.boxDecorationDiscountContainer,
      child: Padding(
        padding: const EdgeInsets.only(
          top: KPadding.kPaddingSize16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _DiscountCardTitleWidget(
              isDesk: isDesk,
              company: discountItem.company,
              userName: discountItem.userName,
              dateVerified: discountItem.dateVerified,
              category: discountItem.category,
              userPhoto: discountItem.userPhoto,
            ),
            if (isDesk)
              KSizedBox.kHeightSizedBox16
            else
              KSizedBox.kHeightSizedBox8,
            IntrinsicHeight(
              child: Container(
                decoration: discountItem.discount.getDiscountString(context) ==
                        context.l10n.free
                    ? KWidgetTheme.boxDecorationDiscountBorder
                    : null,
                child: Row(
                  children: [
                    if (discountItem.images != null &&
                        discountItem.images!.isNotEmpty)
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(KSize.kRadius32),
                              topLeft: Radius.circular(KSize.kRadius32),
                            ),
                            child: NetworkImageWidget(
                              imageUrl: discountItem.images![0].downloadURL,
                            ),
                          ),
                          Positioned(
                            top: KPadding.kPaddingSize16,
                            right: KPadding.kPaddingSize16,
                            child: DecoratedBox(
                              decoration: KWidgetTheme.boxDecorationDiscount,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: KPadding.kPaddingSize8,
                                  vertical: KPadding.kPaddingSize4,
                                ),
                                child: TextPointWidget(
                                  discountItem.discount
                                      .getDiscountString(context),
                                  key: KWidgetkeys.widget.discountCard.discount,
                                  mainAxisSize: MainAxisSize.min,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    Flexible(
                      child: _DiscountCardDesciprtionWidget(
                        isDesk: isDesk,
                        descriptionMethod: descriptionMethod,
                        discountItem: discountItem,
                        closeWidget: closeWidget,
                        isBusiness: isBusiness,
                        share: share,
                        useSiteUrl: useSiteUrl,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DiscountCardDesciprtionWidget extends StatelessWidget {
  const _DiscountCardDesciprtionWidget({
    required this.isDesk,
    required this.closeWidget,
    required this.descriptionMethod,
    required this.discountItem,
    required this.share,
    required this.isBusiness,
    required this.useSiteUrl,
  });
  final bool isDesk;
  final Widget? closeWidget;
  final DiscountModel discountItem;
  final String Function(String)? descriptionMethod;
  final String? share;
  final bool isBusiness;
  final bool? useSiteUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          (discountItem.images != null && discountItem.images!.isNotEmpty)
              ? KWidgetTheme.boxDecorationWidgetWithImage
              : KWidgetTheme.boxDecorationWidget,
      padding: EdgeInsets.symmetric(
        horizontal: isDesk ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment:
            (discountItem.images != null && discountItem.images!.isNotEmpty)
                ? CrossAxisAlignment.stretch
                : CrossAxisAlignment.start,
        children: [
          KSizedBox.kHeightSizedBox16,
          _DescrptionTitleWidget(
            isDesk: isDesk,
            category: discountItem.category,
            discount: discountItem.discount,
            title: discountItem.title,
            hasImage: discountItem.images != null,
          ),
          if (!isDesk) ...[
            KSizedBox.kHeightSizedBox8,
            Text(
              discountItem.title.getTrsnslation(context),
              key: KWidgetkeys.widget.discountCard.discountTitle,
              style: AppTextStyle.materialThemeHeadlineSmall,
              overflow: TextOverflow.clip,
            ),
          ],
          KSizedBox.kHeightSizedBox4,
          _CitiesExpirationWidget(
            isDesk: isDesk,
            location: discountItem.location,
            expiration: discountItem.expiration,
            subLocation: discountItem.subLocation,
          ),
          KSizedBox.kHeightSizedBox16,
          DiscountTextWidget(
            key: KWidgetkeys.widget.discountCard.description,
            description: descriptionMethod == null
                ? discountItem.getDescription(context)
                : descriptionMethod!(
                    discountItem.getDescription(context),
                  ),
            isDesk: isDesk,
            text: discountItem.eligibility,
            button: TextButton(
              key: KWidgetkeys.screen.company.boxMyDiscounts,
              onPressed: () {},
              style: KButtonStyles.blackDetailsButtonStyle,
              child: Text(
                context.l10n.moreDetails,
                style: AppTextStyle.materialThemeTitleMediumNeutral,
              ),
            ),
            icon: SharedIconListWidget(
              isDesk: isDesk,
              // if this is iOS and medical services, do not offer
              // pointing to the website
              link: discountItem.getLink,
              useSiteUrl: useSiteUrl,
              cardEnum: CardEnum.discount,
              discountItem: discountItem,
              // afterEvent: reportEvent,
              cardId: discountItem.id,
              share: share,
              complaintKey: KWidgetkeys.widget.discountCard.iconComplaint,
              shareKey: KWidgetkeys.widget.discountCard.iconShare,
              likeKey: KWidgetkeys.widget.discountCard.iconLike,
              webSiteKey: KWidgetkeys.widget.discountCard.iconWebsite,
              showComplaint: !isBusiness,
              showShare:
                  !isBusiness || discountItem.status == DiscountState.published,
            ),
          ),
          KSizedBox.kHeightSizedBox16,
          if (closeWidget != null) ...[
            closeWidget!,
            KSizedBox.kHeightSizedBox16,
          ],
        ],
      ),
    );
  }
}

class _DescrptionTitleWidget extends StatelessWidget {
  const _DescrptionTitleWidget({
    required this.isDesk,
    required this.category,
    required this.discount,
    required this.title,
    this.hasImage = false,
  });
  final bool isDesk;
  final List<TranslateModel> category;
  final List<int> discount;
  final TranslateModel title;
  final bool hasImage;

  @override
  Widget build(BuildContext context) {
    if (isDesk) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title.getTrsnslation(context),
              key: KWidgetkeys.widget.discountCard.discountTitle,
              style: AppTextStyle.materialThemeHeadlineSmall,
            ),
          ),
          if (!hasImage) ...[
            KSizedBox.kWidthSizedBox30,
            DecoratedBox(
              decoration: KWidgetTheme.boxDecorationDiscount,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: KPadding.kPaddingSize8,
                  vertical: KPadding.kPaddingSize4,
                ),
                child: TextPointWidget(
                  discount.getDiscountString(context),
                  key: KWidgetkeys.widget.discountCard.discount,
                  mainAxisSize: MainAxisSize.min,
                ),
              ),
            ),
          ],
        ],
      );
    } else {
      return Align(
        alignment: Alignment.centerRight,
        child: DecoratedBox(
          decoration: KWidgetTheme.boxDecorationDiscount,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: KPadding.kPaddingSize8,
              vertical: KPadding.kPaddingSize4,
            ),
            child: TextPointWidget(
              discount.getDiscountString(context),
              key: KWidgetkeys.widget.discountCard.discount,
              mainAxisSize: MainAxisSize.min,
            ),
          ),
        ),
      );
    }
  }
}

class _DiscountCardTitleWidget extends StatelessWidget {
  const _DiscountCardTitleWidget({
    required this.isDesk,
    required this.company,
    required this.userName,
    required this.dateVerified,
    required this.category,
    required this.userPhoto,
  });
  final bool isDesk;
  final TranslateModel? company;
  final String? userName;
  final DateTime dateVerified;
  final List<TranslateModel> category;
  final ImageModel? userPhoto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: isDesk ? KPadding.kPaddingSize16 : KPadding.kPaddingSize16,
        left: isDesk ? KPadding.kPaddingSize16 : KPadding.kPaddingSize16,
        bottom: isDesk ? KPadding.kPaddingSize16 : KPadding.kPaddingSize8,
        top: KPadding.kPaddingSize16,
      ),
      child: isDesk
          ? Row(
              // alignment: WrapAlignment.spaceBetween,
              // crossAxisAlignment: WrapCrossAlignment.center,
              // spacing: KPadding.kPaddingSize16,
              // runSpacing: KPadding.kPaddingSize16,
              children: [
                Expanded(
                  child: _CompanyInfoWidget(
                    dateVerified: dateVerified,
                    category: category,
                    company: company,
                    userName: userName,
                    userPhoto: userPhoto,
                  ),
                ),
                // KSizedBox.kWidthSizedBox16,
                // _CategoryWidget(
                //   categories: category,
                //   categoriesEn: categoryEN,
                // ),
              ],
            )
          : _CompanyInfoWidget(
              dateVerified: dateVerified,
              category: category,
              company: company,
              userName: userName,
              userPhoto: userPhoto,
            ),
    );
  }
}

class _CompanyInfoWidget extends StatelessWidget {
  const _CompanyInfoWidget({
    required this.dateVerified,
    required this.category,
    required this.company,
    required this.userName,
    required this.userPhoto,
  });
  final TranslateModel? company;
  final String? userName;
  final DateTime dateVerified;
  final List<TranslateModel> category;
  final ImageModel? userPhoto;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UserPhotoWidget(
          imageUrl: userPhoto?.downloadURL,
          onPressed: null,
          imageName: userPhoto?.name,
        ),
        KSizedBox.kWidthSizedBox16,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                key: KWidgetkeys.widget.discountCard.service,
                company?.getTrsnslation(context) ??
                    context.l10n.companyIsHidden,
                style: AppTextStyle.materialThemeTitleMedium,
                overflow: TextOverflow.clip,
                textAlign: TextAlign.left,
              ),
              Wrap(
                children: [
                  Text(
                    key: KWidgetkeys.widget.discountCard.userName,
                    userName ?? KAppText.veteranamName,
                    style: AppTextStyle.materialThemeLabelSmall,
                  ),
                  KSizedBox.kWidthSizedBox8,
                  Text(
                    key: KWidgetkeys.widget.discountCard.date,
                    dateVerified.toLocalDateString(context: context),
                    style: AppTextStyle.materialThemeLabelSmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// class _CompanyInformationWidget extends StatelessWidget {
//   const _CompanyInformationWidget({
//     required this.company,
//     required this.userName,
//     required this.dateVerified,
//   });
//   final TranslateModel? company;
//   final String? userName;
//   final DateTime dateVerified;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           key: KWidgetkeys.widget.discountCard.service,
//           company?.getTrsnslation(context) ?? context.l10n.companyIsHidden,
//           style: AppTextStyle.materialThemeTitleMedium,
//           overflow: TextOverflow.clip,
//           textAlign: TextAlign.left,
//         ),
//         Wrap(
//           children: [
//             Text(
//               key: KWidgetkeys.widget.discountCard.userName,
//               userName ?? KAppText.veteranamName,
//               style: AppTextStyle.materialThemeLabelSmall,
//             ),
//             KSizedBox.kWidthSizedBox8,
//             Text(
//               key: KWidgetkeys.widget.discountCard.date,
//               dateVerified.toLocalDateString(context: context),
//               style: AppTextStyle.materialThemeLabelSmall,
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class _CategoryWidget extends StatelessWidget {
//   const _CategoryWidget({
//     required this.categories,
//   });
//   final List<TranslateModel> categories;

//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       runSpacing: KPadding.kPaddingSize4,
//       children: List.generate(categories.length, (int index) {
//         return Container(
//           constraints: const BoxConstraints(minHeight:
// KMinMaxSize.minHeight30),
//           padding: const EdgeInsets.symmetric(
//             //vertical: KPadding.kPaddingSize4,
//             horizontal: KPadding.kPaddingSize8,
//           ),
//           decoration: KWidgetTheme.boxDecorationDiscountCategory,
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               KIcon.check,
//               KSizedBox.kWidthSizedBox8,
//               Padding(
//                 padding: const EdgeInsets.only(
//                   right: KPadding.kPaddingSize5,
//                 ),
//                 child: Text(
//                   key: KWidgetkeys.widget.discountCard.category,
//                   categories.elementAt(index).getTrsnslation(context),
//                   style: AppTextStyle.materialThemeLabelLarge,
//                 ),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }

class _CitiesExpirationWidget extends StatelessWidget {
  const _CitiesExpirationWidget({
    required this.isDesk,
    required this.location,
    required this.expiration,
    required this.subLocation,
  });
  final bool isDesk;
  final List<TranslateModel>? location;
  final TranslateModel? expiration;
  final SubLocation? subLocation;
  @override
  Widget build(BuildContext context) {
    if (isDesk) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ExpirationWidget(
            expiration: expiration?.getTrsnslation(
              context,
            ),
          ),
          KSizedBox.kWidthSizedBox16,
          Expanded(
            child: CityListWidget(
              key: KWidgetkeys.widget.discountCard.city,
              location: location,
              subLocation: subLocation,
              isDesk: true,
            ),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ExpirationWidget(
            expiration: expiration?.getTrsnslation(
              context,
            ),
          ),
          KSizedBox.kHeightSizedBox8,
          CityListWidget(
            key: KWidgetkeys.widget.discountCard.city,
            isDesk: false,
            location: location,
            subLocation: subLocation,
          ),
        ],
      );
    }
  }
}

class _ExpirationWidget extends StatelessWidget {
  const _ExpirationWidget({required this.expiration});
  final String? expiration;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: KMinMaxSize.minHeight30),
      // padding: const EdgeInsets.symmetric(
      //   vertical: KPadding.kPaddingSize4,
      //   horizontal: KPadding.kPaddingSize8,
      // ),
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
              ((expiration == null || expiration!.isEmpty)
                  ? context.l10n.itIsValidAllTime
                  : expiration!),
              key: KWidgetkeys.widget.discountCard.expiration,
              style: AppTextStyle.materialThemeLabelLarge,
            ),
          ),
        ],
      ),
    );
  }
}
