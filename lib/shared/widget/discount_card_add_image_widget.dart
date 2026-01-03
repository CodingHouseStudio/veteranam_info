import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountCardAddImageWidget extends StatelessWidget {
  const DiscountCardAddImageWidget({
    required this.discountItem,
    required this.isDesk,
    required this.isBusiness,
    required this.closeWidget,
    required this.share,
    required this.descriptionMethod,
    required this.useSiteUrl,
    required this.dialogIsDesk,
    super.key,
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
    if (discountItem.hasImages) {
      final children = [
        _DiscountCardWithImage(
          discountItem: discountItem,
          borderRadious: isDesk
              ? KBorderRadius.kBorderRadiusOnlyLeft
              : KBorderRadius.kBorderRadiusOnlyTop,
        ),
        Flexible(
          child: DiscountCardDesciprtionWidget(
            isDesk: isDesk,
            descriptionMethod: descriptionMethod,
            discountItem: discountItem,
            closeWidget: closeWidget,
            isBusiness: isBusiness,
            share: share,
            useSiteUrl: useSiteUrl,
            dialogIsDesk: dialogIsDesk,
            decoration: KWidgetTheme.boxDecorationWidget,
            titleDeskWidget: Expanded(
              child: Text(
                discountItem.title.getTrsnslation(context),
                key: DiscountCardKeys.discountTitle,
                style: AppTextStyle.materialThemeHeadlineSmall,
              ),
            ),
          ),
        ),
      ];
      return IntrinsicHeight(
        child: Container(
          decoration: discountItem.discount.getDiscountString(context) ==
                  context.l10n.free
              ? KWidgetTheme.boxDecorationDiscountBorder
              : null,
          child: isDesk
              ? Row(
                  children: children,
                )
              : Column(
                  children: children,
                ),
        ),
      );
    } else {
      return DecoratedBox(
        decoration: discountItem.discount.getDiscountString(context) ==
                context.l10n.free
            ? KWidgetTheme.boxDecorationDiscountBorder
            : const BoxDecoration(),
        child: DiscountCardDesciprtionWidget(
          isDesk: isDesk,
          descriptionMethod: descriptionMethod,
          discountItem: discountItem,
          closeWidget: closeWidget,
          isBusiness: isBusiness,
          share: share,
          useSiteUrl: useSiteUrl,
          dialogIsDesk: dialogIsDesk,
        ),
      );
    }
  }
}

class _DiscountCardWithImage extends StatelessWidget {
  const _DiscountCardWithImage({
    required this.discountItem,
    required this.borderRadious,
  });

  final DiscountModel discountItem;
  final BorderRadiusGeometry borderRadious;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: borderRadious,
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
                  discountItem.discount.getDiscountString(context),
                  key: DiscountCardKeys.discount,
                  mainAxisSize: MainAxisSize.min,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
