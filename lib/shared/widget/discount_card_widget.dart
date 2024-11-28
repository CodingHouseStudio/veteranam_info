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
              userName: discountItem.userName,
              dateVerified: discountItem.dateVerified,
              category: discountItem.category,
              userPhoto: discountItem.userPhoto,
            ),
            if (isDesk)
              KSizedBox.kHeightSizedBox16
            else
              KSizedBox.kHeightSizedBox8,
            _DiscountCardDesciprtionWidget(
              isDesk: isDesk,
              descriptionMethod: descriptionMethod,
              discountItem: discountItem,
              closeWidget: closeWidget,
              isLoading: isLoading,
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
    required this.isLoading,
    required this.share,
    required this.isBusiness,
    required this.useSiteUrl,
  });
  final bool isDesk;
  final Widget? closeWidget;
  final DiscountModel discountItem;
  final String Function(String)? descriptionMethod;
  final bool isLoading;
  final String? share;
  final bool isBusiness;
  final bool? useSiteUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: KWidgetTheme.boxDecorationWidget,
      padding: EdgeInsets.symmetric(
        horizontal: isDesk ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KSizedBox.kHeightSizedBox16,
          _DescrptionTitleWidget(
            isDesk: isDesk,
            category: discountItem.category,
            discount: discountItem.discount,
            title: discountItem.title,
          ),
          if (!isDesk) ...[
            KSizedBox.kHeightSizedBox16,
            Text(
              discountItem.title.getTrsnslation(context),
              key: KWidgetkeys.widget.discountCard.discountTitle,
              style: AppTextStyle.materialThemeHeadlineSmall,
              overflow: TextOverflow.clip,
            ),
          ],
          KSizedBox.kHeightSizedBox16,
          _CitiesExpirationWidget(
            isDesk: isDesk,
            location: discountItem.location,
            expiration: discountItem.expiration,
            subLocation: discountItem.subLocation,
          ),
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
  });
  final bool isDesk;
  final List<TranslateModel> category;
  final List<int> discount;
  final TranslateModel title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (isDesk)
          Expanded(
            child: Text(
              title.getTrsnslation(context),
              key: KWidgetkeys.widget.discountCard.discountTitle,
              style: AppTextStyle.materialThemeDisplaySmall,
            ),
          )
        else
          Expanded(
            child: _CategoryWidget(
              categories: category,
            ),
          ),
        KSizedBox.kHeightSizedBox8,
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
        right: isDesk ? KPadding.kPaddingSize28 : KPadding.kPaddingSize16,
        left: isDesk ? KPadding.kPaddingSize28 : KPadding.kPaddingSize16,
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
                KSizedBox.kWidthSizedBox16,
                _CategoryWidget(
                  categories: category,
                ),
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
        Expanded(child: companyInfo),
      ],
    );
  }

  Widget get companyInfo => _CompanyInformationWidget(
        company: company,
        userName: userName,
        dateVerified: dateVerified,
      );
}

class _CompanyInformationWidget extends StatelessWidget {
  const _CompanyInformationWidget({
    required this.company,
    required this.userName,
    required this.dateVerified,
  });
  final TranslateModel? company;
  final String? userName;
  final DateTime dateVerified;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          key: KWidgetkeys.widget.discountCard.service,
          company?.getTrsnslation(context) ?? context.l10n.companyIsHidden,
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
  });
  final List<TranslateModel> categories;

  @override
  Widget build(BuildContext context) {
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
                  categories.elementAt(index).getTrsnslation(context),
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
