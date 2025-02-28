import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    this.dialogIsDesk,
  });

  final DiscountModel discountItem;
  final bool isDesk;
  // final void Function()? reportEvent;
  final Widget? closeWidget;
  final String? share;
  final String Function(String)? descriptionMethod;
  final bool isBusiness;
  final bool? useSiteUrl;
  final bool? dialogIsDesk;

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
          spacing: isDesk ? KPadding.kPaddingSize16 : KPadding.kPaddingSize8,
          children: [
            _DiscountCardTitleWidget(
              isDesk: isDesk,
              company: discountItem.company,
              userName: discountItem.userName,
              dateVerified: discountItem.dateVerified,
              category: discountItem.category,
              userPhoto: discountItem.userPhoto,
            ),
            DiscountCardAddImageWidget(
              discountItem: discountItem,
              isDesk: isDesk,
              isBusiness: isBusiness,
              closeWidget: closeWidget,
              share: share,
              descriptionMethod: descriptionMethod,
              useSiteUrl: useSiteUrl,
              dialogIsDesk: dialogIsDesk,
            ),
          ],
        ),
      ),
    );
  }
}

class DiscountCardDesciprtionWidget extends StatelessWidget {
  const DiscountCardDesciprtionWidget({
    required this.isDesk,
    required this.closeWidget,
    required this.descriptionMethod,
    required this.discountItem,
    required this.share,
    required this.isBusiness,
    required this.useSiteUrl,
    required this.dialogIsDesk,
    super.key,
    this.decoration,
    this.titleDeskWidget,
  });
  final bool isDesk;
  final Widget? closeWidget;
  final DiscountModel discountItem;
  final String Function(String)? descriptionMethod;
  final String? share;
  final bool isBusiness;
  final bool? useSiteUrl;
  final bool? dialogIsDesk;
  final Decoration? decoration;
  final Widget? titleDeskWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration ??
          (isDesk
              ? KWidgetTheme.boxDecorationWidgetDeskWithImage
              : KWidgetTheme.boxDecorationWidgetMobWithImage),
      padding: EdgeInsets.symmetric(
        horizontal: isDesk ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: discountItem.hasImages
            ? CrossAxisAlignment.stretch
            : CrossAxisAlignment.start,
        children: [
          if (isDesk)
            KSizedBox.kHeightSizedBox16
          else
            KSizedBox.kHeightSizedBox8,
          _DescrptionTitleWidget(
            isDesk: isDesk,
            category: discountItem.category,
            discount: discountItem.discount,
            title: discountItem.title,
            titleDeskWidget: titleDeskWidget,
          ),
          if (!isDesk) ...[
            KSizedBox.kHeightSizedBox8,
            Text(
              discountItem.title.getTrsnslation(context),
              key: DiscountCardKeys.discountTitle,
              style: AppTextStyle.materialThemeHeadlineSmall,
              overflow: TextOverflow.clip,
            ),
          ],
          KSizedBox.kHeightSizedBox4,
          _CitiesExpirationWidget(
            isDesk: isDesk,
            discountItem: discountItem,
          ),
          KSizedBox.kHeightSizedBox16,
          DiscountTextWidget(
            key: DiscountCardKeys.description,
            description: descriptionMethod == null
                ? discountItem.getDescription(context)
                : descriptionMethod!(
                    discountItem.getDescription(context),
                  ),
            isDesk: isDesk,
            eligibility: discountItem.eligibility,
            moreButtonEvent: () => context.goNamed(
              KRoute.discount.name,
              pathParameters: {
                UrlParameters.cardId: discountItem.id,
              },
              extra: discountItem,
            ),
            button: TextButton(
              key: DiscountCardKeys.button,
              onPressed: () => context.goNamed(
                KRoute.discount.name,
                pathParameters: {
                  UrlParameters.cardId: discountItem.id,
                },
                extra: discountItem,
              ),
              style: KButtonStyles.blackDetailsButtonStyle,
              child: Text(
                context.l10n.moreDetails,
                style: AppTextStyle.materialThemeTitleMediumNeutral,
              ),
            ),
            icon: SharedIconListWidget(
              isDesk: isDesk,
              dialogIsDesk: dialogIsDesk,
              // if this is iOS and medical services, do not offer
              // pointing to the website
              link: discountItem.getLink,
              useSiteUrl: useSiteUrl,
              cardEnum: CardEnum.discount,
              numberLikes: discountItem.likes,
              // afterEvent: reportEvent,
              cardId: discountItem.id,
              share: share,
              complaintKey: DiscountCardKeys.iconComplaint,
              shareKey: DiscountCardKeys.iconShare,
              likeKey: DiscountCardKeys.iconLike,
              webSiteKey: DiscountCardKeys.iconWebsite,
              showComplaint: !isBusiness,
              showShare:
                  !isBusiness || discountItem.status == DiscountState.published,
              dropMenuKey: DiscountCardKeys.popupMenuButton,
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
    this.titleDeskWidget,
  });
  final bool isDesk;
  final List<TranslateModel> category;
  final List<int> discount;
  final TranslateModel title;
  final Widget? titleDeskWidget;

  @override
  Widget build(BuildContext context) {
    if (isDesk) {
      return titleDeskWidget ??
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: KPadding.kPaddingSize30,
            children: [
              Expanded(
                child: Text(
                  title.getTrsnslation(context),
                  key: DiscountCardKeys.discountTitle,
                  style: AppTextStyle.materialThemeHeadlineSmall,
                ),
              ),
              DecoratedBox(
                decoration: KWidgetTheme.boxDecorationDiscount,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: KPadding.kPaddingSize8,
                    vertical: KPadding.kPaddingSize4,
                  ),
                  child: TextPointWidget(
                    discount.getDiscountString(context),
                    key: DiscountCardKeys.discount,
                    mainAxisSize: MainAxisSize.min,
                  ),
                ),
              ),
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
              key: DiscountCardKeys.discount,
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
      padding: EdgeInsets.symmetric(
        horizontal: isDesk ? KPadding.kPaddingSize28 : KPadding.kPaddingSize16,
      ),
      child: isDesk
          ? CompanyInfoWidget(
              dateVerified: dateVerified,
              category: category,
              company: company,
              userName: userName,
              userPhoto: userPhoto,
            )
          : CompanyInfoWidget(
              dateVerified: dateVerified,
              category: category,
              company: company,
              userName: userName,
              userPhoto: userPhoto,
            ),
    );
  }
}

class CompanyInfoWidget extends StatelessWidget {
  const CompanyInfoWidget({
    required this.dateVerified,
    required this.category,
    required this.company,
    required this.userName,
    required this.userPhoto,
    super.key,
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
                key: DiscountCardKeys.service,
                company?.getTrsnslation(context) ??
                    context.l10n.companyIsHidden,
                style: AppTextStyle.materialThemeTitleMedium,
                overflow: TextOverflow.clip,
                textAlign: TextAlign.left,
              ),
              Wrap(
                spacing: KPadding.kPaddingSize8,
                runSpacing: KPadding.kPaddingSize8,
                children: [
                  Text(
                    key: DiscountCardKeys.userName,
                    userName ?? KAppText.veteranamName,
                    style: AppTextStyle.materialThemeLabelSmall,
                  ),
                  Text(
                    key: DiscountCardKeys.date,
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
//           key: DiscountCardKeys.service,
//           company?.getTrsnslation(context) ?? context.l10n.companyIsHidden,
//           style: AppTextStyle.materialThemeTitleMedium,
//           overflow: TextOverflow.clip,
//           textAlign: TextAlign.left,
//         ),
//         Wrap(
//           children: [
//             Text(
//               key: DiscountCardKeys.userName,
//               userName ?? KAppText.veteranamName,
//               style: AppTextStyle.materialThemeLabelSmall,
//             ),
//             KSizedBox.kWidthSizedBox8,
//             Text(
//               key: DiscountCardKeys.date,
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
//                   key: DiscountCardKeys.category,
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
    required this.discountItem,
  });
  final bool isDesk;
  final DiscountModel discountItem;
  @override
  Widget build(BuildContext context) {
    void moreButtonEvent() => context.goNamed(
          KRoute.discount.name,
          pathParameters: {
            UrlParameters.cardId: discountItem.id,
          },
          extra: discountItem,
        );
    if (isDesk) {
      return Row(
        spacing: KPadding.kPaddingSize16,
        children: [
          ExpirationWidget(
            expiration: discountItem.expiration?.getTrsnslation(
              context,
            ),
          ),
          Expanded(
            child: CityListWidget(
              key: DiscountCardKeys.city,
              buttonKey: DiscountCardKeys.cityMoreButton,
              location: discountItem.location,
              subLocation: discountItem.subLocation,
              moreButtonEvent: moreButtonEvent,
              isDesk: true,
            ),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: KPadding.kPaddingSize4,
        children: [
          ExpirationWidget(
            expiration: discountItem.expiration?.getTrsnslation(
              context,
            ),
          ),
          CityListWidget(
            key: DiscountCardKeys.city,
            buttonKey: DiscountCardKeys.cityMoreButton,
            isDesk: false,
            moreButtonEvent: moreButtonEvent,
            location: discountItem.location,
            subLocation: discountItem.subLocation,
          ),
        ],
      );
    }
  }
}

class ExpirationWidget extends StatelessWidget {
  const ExpirationWidget({required this.expiration, super.key});
  final String? expiration;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: KMinMaxSize.minHeight30),
      // padding: const EdgeInsets.symmetric(
      //   vertical: KPadding.kPaddingSize4,
      //   horizontal: KPadding.kPaddingSize8,
      // ),
      child: Row(
        spacing: KPadding.kPaddingSize8,
        mainAxisSize: MainAxisSize.min,
        children: [
          KIcon.date,
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(
                right: KPadding.kPaddingSize4,
              ),
              child: Text(
                ((expiration == null || expiration!.isEmpty)
                    ? context.l10n.itIsValidAllTime
                    : expiration!),
                key: DiscountCardKeys.expiration,
                style: AppTextStyle.materialThemeLabelLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
