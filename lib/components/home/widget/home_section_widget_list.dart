import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/home/widget/widget.dart';
import 'package:veteranam/shared/shared_dart.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountSection extends StatelessWidget {
  const DiscountSection({
    required this.isDesk,
    required this.isTablet,
    required this.padding,
    super.key,
  });

  final bool isDesk;
  final bool isTablet;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    if (isDesk) {
      return Padding(
        padding: padding,
        child: HomeScreenCard(
          rightWidget: Padding(
            padding: const EdgeInsets.only(
              left: KPadding.kPaddingSize48,
            ),
            child: SectionWidget(
              buttonKey: KWidgetkeys.screen.home.discountButton,
              // prefixKey: KWidgetkeys.screen.home.discountPrefix,
              titleKey: KWidgetkeys.screen.home.discountTitle,
              subtitleKey: KWidgetkeys.screen.home.discountSubtitle,
              // textPoint: context.l10n.saveMoney,
              title: context.l10n.discountsServices,
              subtitle: context.l10n.discountsServicesSubtitle,
              textButton: context.l10n.toDiscount,
              route: () => context.goNamed(KRoute.discounts.name),
              bottomWidget: KSizedBox.kHeightSizedBox90,
              isDesk: isTablet,
            ),
          ),
          leftWidget: KImage.discountImage(
            key: KWidgetkeys.screen.home.discountImage,
          ),
          rightPadding: KPadding.kPaddingSize84,
        ),
      );
    } else {
      return Padding(
        padding: padding,
        child: Column(
          children: [
            KImage.discountImage(
              key: KWidgetkeys.screen.home.discountImage,
            ),
            if (isTablet)
              KSizedBox.kHeightSizedBox48
            else
              KSizedBox.kHeightSizedBox16,
            SectionWidget(
              buttonKey: KWidgetkeys.screen.home.discountButton,
              // prefixKey: KWidgetkeys.screen.home.discountPrefix,
              titleKey: KWidgetkeys.screen.home.discountTitle,
              subtitleKey: KWidgetkeys.screen.home.discountSubtitle,
              // textPoint: context.l10n.saveMoney,
              title: context.l10n.discountsServices,
              subtitle: context.l10n.discountsServicesSubtitle,
              textButton: context.l10n.toDiscount,
              route: () => context.goNamed(KRoute.discounts.name),
              bottomWidget: KSizedBox.kHeightSizedBox90,
              isDesk: isTablet,
            ),
          ],
        ),
      );
    }
  }
}

// Widget getDiscountSection({
//   required BuildContext context,
//   required bool isTablet,
// }) =>
//     SectionWidget(
//       buttonKey: KWidgetkeys.screen.home.discountButton,
//       // prefixKey: KWidgetkeys.screen.home.discountPrefix,
//       titleKey: KWidgetkeys.screen.home.discountTitle,
//       subtitleKey: KWidgetkeys.screen.home.discountSubtitle,
//       // textPoint: context.l10n.saveMoney,
//       title: context.l10n.discountsServices,
//       subtitle: context.l10n.discountsServicesSubtitle,
//       textButton: context.l10n.toDiscount,
//       route: () => context.goNamed(KRoute.discounts.name),
//       bottomWidget: KSizedBox.kHeightSizedBox90,
//       isDesk: isTablet,
//     );

class InformationSection extends StatelessWidget {
  const InformationSection({
    required this.isDesk,
    required this.isTablet,
    required this.padding,
    super.key,
  });

  final bool isDesk;
  final bool isTablet;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    if (isDesk) {
      return Padding(
        padding: padding,
        child: HomeScreenCard(
          leftWidget: Padding(
            padding: const EdgeInsets.only(
              right: KPadding.kPaddingSize48,
            ),
            child: SectionWidget(
              buttonKey: KWidgetkeys.screen.home.informationButton,
              // prefixKey: KWidgetkeys.screen.home.informationPrefix,
              subtitleKey: KWidgetkeys.screen.home.informationSubtitle,
              titleKey: KWidgetkeys.screen.home.informationTitle,
              // textPoint: context.l10n.findOut,
              title: context.l10n.informationNews,
              subtitle: context.l10n.informationNewsSubtitle,
              textButton: context.l10n.toInfomation,
              route: () => context.goNamed(KRoute.information.name),
              bottomWidget: KSizedBox.kHeightSizedBox48,
              isDesk: isTablet,
            ),
          ),
          rightWidget: KImage.inforamationImage(
            key: KWidgetkeys.screen.home.informationImage,
          ),
          rightPadding: KPadding.kPaddingSize32,
        ),
      );
    } else {
      return Padding(
        padding: padding,
        child: Column(
          children: [
            KImage.inforamationImage(
              key: KWidgetkeys.screen.home.informationImage,
            ),
            if (isTablet)
              KSizedBox.kWidthSizedBox48
            else
              KSizedBox.kHeightSizedBox16,
            SectionWidget(
              buttonKey: KWidgetkeys.screen.home.informationButton,
              // prefixKey: KWidgetkeys.screen.home.informationPrefix,
              subtitleKey: KWidgetkeys.screen.home.informationSubtitle,
              titleKey: KWidgetkeys.screen.home.informationTitle,
              // textPoint: context.l10n.findOut,
              title: context.l10n.informationNews,
              subtitle: context.l10n.informationNewsSubtitle,
              textButton: context.l10n.toInfomation,
              route: () => context.goNamed(KRoute.information.name),
              bottomWidget: KSizedBox.kHeightSizedBox48,
              isDesk: isTablet,
            ),
          ],
        ),
      );
    }
  }
}

// Widget getInformationSection({
//   required BuildContext context,
//   required bool isTablet,
// }) =>
//     SectionWidget(
//       buttonKey: KWidgetkeys.screen.home.informationButton,
//       // prefixKey: KWidgetkeys.screen.home.informationPrefix,
//       subtitleKey: KWidgetkeys.screen.home.informationSubtitle,
//       titleKey: KWidgetkeys.screen.home.informationTitle,
//       // textPoint: context.l10n.findOut,
//       title: context.l10n.informationNews,
//       subtitle: context.l10n.informationNewsSubtitle,
//       textButton: context.l10n.toInfomation,
//       route: () => context.goNamed(KRoute.information.name),
//       bottomWidget: KSizedBox.kHeightSizedBox48,
//       isDesk: isTablet,
//     );
