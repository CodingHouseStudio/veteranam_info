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
              companyEN: discountItem.companyEN,
              userName: discountItem.userName,
              dateVerified: discountItem.dateVerified,
              category: discountItem.category,
              categoryEN: discountItem.categoryEN,
              userPhoto: discountItem.userPhoto,
            ),
            if (isDesk)
              KSizedBox.kHeightSizedBox16
            else
              KSizedBox.kHeightSizedBox8,
            // if (discountItem.images != null) ...[
            //   Row(
            //     children: [
            //       print('dfkkdf: ${discountItem.images}'),
            //       Image.network(
            //         discountItem.images![0].downloadURL,
            //         fit: BoxFit.cover,
            //       ),
            //       _DiscountCardDesciprtionWidget(
            //         isDesk: isDesk,
            //         descriptionMethod: descriptionMethod,
            //         discountItem: discountItem,
            //         closeWidget: closeWidget,
            //         isBusiness: isBusiness,
            //         share: share,
            //         useSiteUrl: useSiteUrl,
            //       ),
            //     ],
            //   ),
            // ] else
            _DiscountCardDesciprtionWidget(
              isDesk: isDesk,
              descriptionMethod: descriptionMethod,
              discountItem: discountItem,
              closeWidget: closeWidget,
              isBusiness: isBusiness,
              share: share,
              useSiteUrl: useSiteUrl,
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
    print('dfkkdf: ${discountItem}');
    return Container(
      decoration: KWidgetTheme.boxDecorationWidget,
      padding: EdgeInsets.symmetric(
        horizontal: isDesk ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16,
      ),
      child:
          // child: discountItem.images != null
          //     ? Row(
          //         children: [
          //           // NetworkImageWidget(
          //           //   imageUrl: discountItem.images.downloadURL,
          //           // ),
          //           Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               KSizedBox.kHeightSizedBox16,
          //               _DescrptionTitleWidget(
          //                 isDesk: isDesk,
          //                 category: discountItem.category,
          //                 discount: discountItem.discount,
          //                 title: discountItem.title,
          //                 categoryEN: discountItem.categoryEN,
          //                 titleEN: discountItem.titleEN,
          //               ),
          //               if (!isDesk) ...[
          //                 KSizedBox.kHeightSizedBox8,
          //                 Text(
          //                   discountItem.title.getTrnslation(
          //                       en: discountItem.titleEN, context: context),
          //                   key: KWidgetkeys.widget.discountCard.discountTitle,
          //                   style: AppTextStyle.materialThemeHeadlineSmall,
          //                   overflow: TextOverflow.clip,
          //                 ),
          //               ],
          //               KSizedBox.kHeightSizedBox4,
          //               _CitiesExpirationWidget(
          //                 isDesk: isDesk,
          //                 location: discountItem.location,
          //                 locationEN: discountItem.locationEN,
          //                 expiration: discountItem.expiration,
          //                 expirationEN: discountItem.expirationEN,
          //                 subLocation: discountItem.subLocation,
          //               ),
          //               KSizedBox.kHeightSizedBox16,
          //               DiscountTextWidget(
          //                 key: KWidgetkeys.widget.discountCard.description,
          //                 description: descriptionMethod == null
          //                     ? discountItem.getDescription(context)
          //                     : descriptionMethod!(
          //                         discountItem.getDescription(context),
          //                       ),
          //                 isDesk: isDesk,
          //                 text: discountItem.eligibility!,
          //                 button: TextButton(
          //                   key: KWidgetkeys.screen.company.boxMyDiscounts,
          //                   onPressed: () {},
          //                   style: KButtonStyles.blackDetailsButtonStyle,
          //                   child: Text(
          //                     context.l10n.moreDetails,
          //                     style: AppTextStyle.materialThemeTitleMediumNeutral,
          //                   ),
          //                 ),
          //                 icon: SharedIconListWidget(
          //                   isDesk: isDesk,
          //                   // if this is iOS and medical services, do not offer
          //                   // pointing to the website
          //                   link: discountItem.getLink,
          //                   useSiteUrl: useSiteUrl,
          //                   cardEnum: CardEnum.discount,
          //                   // afterEvent: reportEvent,
          //                   cardId: discountItem.id,
          //                   share: share,
          //                   complaintKey:
          //                       KWidgetkeys.widget.discountCard.iconComplaint,
          //                   shareKey: KWidgetkeys.widget.discountCard.iconShare,
          //                   webSiteKey: KWidgetkeys.widget.discountCard.iconWebsite,
          //                   showComplaint: !isBusiness,
          //                   showShare: !isBusiness ||
          //                       discountItem.status == DiscountState.published,
          //                 ),
          //               ),
          //               KSizedBox.kHeightSizedBox16,
          //               if (closeWidget != null) ...[
          //                 closeWidget!,
          //                 KSizedBox.kHeightSizedBox16,
          //               ],
          //             ],
          //           ),
          //         ],
          //       )
          // :
          Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KSizedBox.kHeightSizedBox16,
          _DescrptionTitleWidget(
            isDesk: isDesk,
            category: discountItem.category,
            discount: discountItem.discount,
            title: discountItem.title,
            categoryEN: discountItem.categoryEN,
            titleEN: discountItem.titleEN,
          ),
          if (!isDesk) ...[
            KSizedBox.kHeightSizedBox8,
            Text(
              discountItem.title
                  .getTrnslation(en: discountItem.titleEN, context: context),
              key: KWidgetkeys.widget.discountCard.discountTitle,
              style: AppTextStyle.materialThemeHeadlineSmall,
              overflow: TextOverflow.clip,
            ),
          ],
          KSizedBox.kHeightSizedBox4,
          _CitiesExpirationWidget(
            isDesk: isDesk,
            location: discountItem.location,
            locationEN: discountItem.locationEN,
            expiration: discountItem.expiration,
            expirationEN: discountItem.expirationEN,
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
            text: discountItem.eligibility!,
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
              // afterEvent: reportEvent,
              cardId: discountItem.id,
              share: share,
              complaintKey: KWidgetkeys.widget.discountCard.iconComplaint,
              shareKey: KWidgetkeys.widget.discountCard.iconShare,
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
    required this.categoryEN,
    required this.titleEN,
  });
  final bool isDesk;
  final List<String> category;
  final List<String>? categoryEN;
  final List<int> discount;
  final String title;
  final String? titleEN;

  @override
  Widget build(BuildContext context) {
    if (isDesk) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title.getTrnslation(en: titleEN, context: context),
              key: KWidgetkeys.widget.discountCard.discountTitle,
              style: AppTextStyle.materialThemeHeadlineSmall,
            ),
          ),
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
    required this.companyEN,
    required this.userName,
    required this.dateVerified,
    required this.category,
    required this.categoryEN,
    required this.userPhoto,
  });
  final bool isDesk;
  final String? company;
  final String? companyEN;
  final String? userName;
  final DateTime dateVerified;
  final List<String> category;
  final List<String>? categoryEN;
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
                    companyEN: companyEN,
                    userName: userName,
                    categoryEN: categoryEN,
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
              companyEN: companyEN,
              userName: userName,
              categoryEN: categoryEN,
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
    required this.companyEN,
    required this.userName,
    required this.categoryEN,
    required this.userPhoto,
  });
  final String? company;
  final String? companyEN;
  final String? userName;
  final DateTime dateVerified;
  final List<String> category;
  final List<String>? categoryEN;
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
        Expanded(child: companyInfo),
      ],
    );
  }

  Widget get companyInfo => _CompanyInformationWidget(
        company: company,
        companyEN: companyEN,
        userName: userName,
        dateVerified: dateVerified,
      );
}

class _CompanyInformationWidget extends StatelessWidget {
  const _CompanyInformationWidget({
    required this.company,
    required this.companyEN,
    required this.userName,
    required this.dateVerified,
  });
  final String? company;
  final String? companyEN;
  final String? userName;
  final DateTime dateVerified;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          key: KWidgetkeys.widget.discountCard.service,
          company.getTrnslation(
                context: context,
                en: companyEN,
              ) ??
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
    );
  }
}

class _CategoryWidget extends StatelessWidget {
  const _CategoryWidget({
    required this.categories,
    required this.categoriesEn,
  });
  final List<String> categories;
  final List<String>? categoriesEn;

  @override
  Widget build(BuildContext context) {
    final categoriesValue = categories.getTrnslation(
      en: categoriesEn,
      context: context,
    );
    return Wrap(
      runSpacing: KPadding.kPaddingSize4,
      children: List.generate(categories.length, (int index) {
        return Container(
          constraints: const BoxConstraints(minHeight: KMinMaxSize.minHeight30),
          padding: const EdgeInsets.symmetric(
            //vertical: KPadding.kPaddingSize4,
            horizontal: KPadding.kPaddingSize8,
          ),
          decoration: KWidgetTheme.boxDecorationDiscountCategory,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              KIcon.check,
              KSizedBox.kWidthSizedBox8,
              Padding(
                padding: const EdgeInsets.only(
                  right: KPadding.kPaddingSize5,
                ),
                child: Text(
                  key: KWidgetkeys.widget.discountCard.category,
                  categoriesValue.elementAt(index),
                  style: AppTextStyle.materialThemeLabelLarge,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _CitiesExpirationWidget extends StatelessWidget {
  const _CitiesExpirationWidget({
    required this.isDesk,
    required this.location,
    required this.locationEN,
    required this.expiration,
    required this.expirationEN,
    required this.subLocation,
  });
  final bool isDesk;
  final List<String>? location;
  final List<String>? locationEN;
  final String? expiration;
  final String? expirationEN;
  final SubLocation? subLocation;
  @override
  Widget build(BuildContext context) {
    if (isDesk) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ExpirationWidget(
            expiration: expiration.getTrnslation(
              en: expirationEN,
              context: context,
            ),
          ),
          KSizedBox.kWidthSizedBox24,
          Expanded(
            child: CityListWidget(
              key: KWidgetkeys.widget.discountCard.city,
              location: location,
              locationEN: locationEN,
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
          CityListWidget(
            key: KWidgetkeys.widget.discountCard.city,
            isDesk: false,
            location: location,
            locationEN: locationEN,
            subLocation: subLocation,
          ),
          KSizedBox.kHeightSizedBox4,
          _ExpirationWidget(
            expiration: expiration.getTrnslation(
              en: expirationEN,
              context: context,
            ),
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
