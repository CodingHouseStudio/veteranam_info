import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

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
    this.isBusiness = false,
    this.useSiteUrl,
  });

  final DiscountModel discountItem;
  final bool isDesk;
  // final void Function()? reportEvent;
  final Widget? closeWidget;
  final String? share;
  final bool isLoading;
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
            // // if (isDesk)
            // //   KSizedBox.kHeightSizedBox16
            // // else
            // //   KSizedBox.kHeightSizedBox8,
            // Container(
            //   decoration: KWidgetTheme.boxDecorationWidget,
            //   padding: EdgeInsets.symmetric(
            //     horizontal:
            //         isDesk ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16,
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       KSizedBox.kHeightSizedBox16,
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           if (isDesk)
            //             Expanded(
            //               child: Text(
            //                 title(context),
            //                 key: KWidgetkeys.widget.discountCard.discountTitle,
            //                 style: AppTextStyle.materialThemeDisplaySmall,
            //                 overflow: TextOverflow.clip,
            //               ),
            //             )
            //           else ...[
            //             Expanded(
            //               child: _CategoryWidget(
            //                 categories: discountItem.category,
            //                 categoriesEn: discountItem.categoryEN,
            //               ),
            //             ),
            //             KSizedBox.kWidthSizedBox8,
            //           ],
            //           Container(
            //             decoration: KWidgetTheme.boxDecorationDiscount,
            //             padding: const EdgeInsets.symmetric(
            //               horizontal: KPadding.kPaddingSize8,
            //               vertical: KPadding.kPaddingSize4,
            //             ),
            //             child: TextPointWidget(
            //               discountItem.discount.getDiscountString(context),
            //               key: KWidgetkeys.widget.discountCard.discount,
            //               // hasExpanded: false,
            //             ),
            //           ),
            //         ],
            //       ),
            //       if (!isDesk) ...[
            //         KSizedBox.kHeightSizedBox16,
            //         Text(
            //           title(context),
            //           key: KWidgetkeys.widget.discountCard.discountTitle,
            //           style: AppTextStyle.materialThemeHeadlineSmall,
            //           overflow: TextOverflow.clip,
            //         ),
            //       ],
            //       KSizedBox.kHeightSizedBox16,
            //       _CitiesExpirationWidget(
            //           isDesk: isDesk, discountItem: discountItem),
            //       KSizedBox.kHeightSizedBox16,
            //       // CardTextDetailWidget(
            //       //   key: KWidgetkeys.widget.discountCard.description,
            //       //   text: descriptionMethod == null
            //       //       ? discountItem.getDescription(context)
            //       //       : descriptionMethod!(
            //       //           discountItem.getDescription(context),
            //       //         ),
            //       //   hasMarkdown: !isLoading,
            //       //   isDesk: isDesk,
            //       //   icon: SharedIconListWidget(
            //       //     context: context,
            //       //     isDesk: isDesk,
            //       //     // if this is iOS and medical services, do not offer
            //       //     // pointing to the website
            //       //     link: discountItem.getLink,
            //       //     useSiteUrl: useSiteUrl,
            //       //     cardEnum: CardEnum.discount,
            //       //     // afterEvent: reportEvent,
            //       //     cardId: discountItem.id,
            //       //     share: share,
            //       //     complaintKey:
            //       //         KWidgetkeys.widget.discountCard.iconComplaint,
            //       //     shareKey: KWidgetkeys.widget.discountCard.iconShare,
            //       //     webSiteKey: KWidgetkeys.widget.discountCard.iconWebsite,
            //       //     showComplaint: !isBusiness,
            //       //     showShare: !isBusiness ||
            //       //         discountItem.status == DiscountState.published,
            //       //   ),
            //       // ),
            //       KSizedBox.kHeightSizedBox16,
            //       if (closeWidget != null) ...[
            //         closeWidget!,
            //         KSizedBox.kHeightSizedBox16,
            //       ],
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  String title(BuildContext context) => discountItem.title
      .getTrnslation(en: discountItem.titleEN, context: context);
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
        right: isDesk ? KPadding.kPaddingSize28 : KPadding.kPaddingSize16,
        left: isDesk ? KPadding.kPaddingSize28 : KPadding.kPaddingSize16,
        bottom: isDesk ? KPadding.kPaddingSize16 : KPadding.kPaddingSize8,
      ),
      child: Row(
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
                  company.getTrnslation(
                        context: context,
                        en: companyEN,
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
                      userName ?? KAppText.veteranamName,
                      style: AppTextStyle.materialThemeLabelSmall,
                    ),
                    KSizedBox.kWidthSizedBox8,
                    Text(
                      key: KWidgetkeys.widget.discountCard.date,
                      dateVerified.toLocalDateString(context: context),
                      style: AppTextStyle.materialThemeLabelSmall,
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (isDesk) ...[
            KSizedBox.kWidthSizedBox16,
            _CategoryWidget(
              categories: category,
              categoriesEn: categoryEN,
            ),
          ],
        ],
      ),
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
    final categoriesWidget = List.generate(categories.length, (int index) {
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
                categories
                    .getTrnslation(
                      en: categoriesEn,
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
    return ScrollConfiguration(
      behavior: CustomScrollBehavior(),
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          // mainAxisEnd: isDesk,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          primary: true,
          itemCount: categoriesWidget.length,
          itemBuilder: (context, index) => categoriesWidget.elementAt(index),
        ),
      ),
    );
  }
}

class _CitiesExpirationWidget extends StatelessWidget {
  const _CitiesExpirationWidget({
    required this.isDesk,
    required this.discountItem,
  });
  final bool isDesk;
  final DiscountModel discountItem;
  @override
  Widget build(BuildContext context) {
    if (isDesk) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ExpirationWidget(
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
      );
    } else {
      return Column(
        children: [
          _ExpirationWidget(
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
