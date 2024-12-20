import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/home/widget/widget.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountSection extends StatelessWidget {
  const DiscountSection({
    required this.isDesk,
    required this.isTablet,
    super.key,
  });

  final bool isDesk;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    if (isDesk) {
      return HomeScreenCard(
        rightWidget: const Padding(
          padding: EdgeInsets.only(
            left: KPadding.kPaddingSize48,
          ),
          child: _DiscountSectionWidget(isTablet: true),
        ),
        leftWidget: KImage.discountImage(
          key: KWidgetkeys.screen.home.discountImage,
        ),
        rightPadding: KPadding.kPaddingSize84,
      );
    } else {
      return Column(
        children: [
          KImage.discountImage(
            key: KWidgetkeys.screen.home.discountImage,
          ),
          if (isTablet)
            KSizedBox.kHeightSizedBox48
          else
            KSizedBox.kHeightSizedBox16,
          _DiscountSectionWidget(isTablet: isTablet),
        ],
      );
    }
  }
}

class InformationSection extends StatelessWidget {
  const InformationSection({
    required this.isDesk,
    required this.isTablet,
    super.key,
  });

  final bool isDesk;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    if (isDesk) {
      return HomeScreenCard(
        leftWidget: const Padding(
          padding: EdgeInsets.only(
            right: KPadding.kPaddingSize48,
          ),
          child: _InformationSectionWidget(isTablet: true),
        ),
        rightWidget: KImage.inforamationImage(
          key: KWidgetkeys.screen.home.informationImage,
        ),
        rightPadding: KPadding.kPaddingSize32,
      );
    } else {
      return Column(
        children: [
          KImage.inforamationImage(
            key: KWidgetkeys.screen.home.informationImage,
          ),
          if (isTablet)
            KSizedBox.kWidthSizedBox48
          else
            KSizedBox.kHeightSizedBox16,
          _InformationSectionWidget(isTablet: isTablet),
        ],
      );
    }
  }
}

class _DiscountSectionWidget extends StatelessWidget {
  const _DiscountSectionWidget({
    required this.isTablet,
  });

  final bool isTablet;
  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      buttonKey: KWidgetkeys.screen.home.discountButton,
      // prefixKey: KWidgetkeys.screen.home.discountPrefix,
      titleKey: KWidgetkeys.screen.home.discountTitle,
      subtitleKey: KWidgetkeys.screen.home.discountSubtitle,
      // textPoint: context.l10n.saveMoney,
      title: context.l10n.discountsServices,
      subtitle: context.l10n.discountsServicesSubtitle,
      textButton:
          '${context.l10n.to.toUpperCase()} ${context.l10n.toDiscounts}',
      route: () => context.goNamed(KRoute.discounts.name),
      bottomWidget: KSizedBox.kHeightSizedBox90,
      isDesk: isTablet,
    );
  }
}

class _InformationSectionWidget extends StatelessWidget {
  const _InformationSectionWidget({
    required this.isTablet,
  });

  final bool isTablet;
  @override
  Widget build(BuildContext context) {
    return SectionWidget(
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
    );
  }
}
