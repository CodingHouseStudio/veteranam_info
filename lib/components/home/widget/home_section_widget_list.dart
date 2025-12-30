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
          key: HomeKeys.discountImage,
        ),
        rightPadding: KPadding.kPaddingSize84,
      );
    } else {
      return Column(
        spacing: isTablet ? KPadding.kPaddingSize48 : KPadding.kPaddingSize16,
        children: [
          KImage.discountImage(
            key: HomeKeys.discountImage,
          ),
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
          key: HomeKeys.informationImage,
        ),
        rightPadding: KPadding.kPaddingSize32,
      );
    } else {
      return Column(
        spacing: isTablet ? KPadding.kPaddingSize48 : KPadding.kPaddingSize16,
        children: [
          KImage.inforamationImage(
            key: HomeKeys.informationImage,
          ),
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
      buttonKey: HomeKeys.discountButton,
      // prefixKey: HomeKeys.discountPrefix,
      titleKey: HomeKeys.discountTitle,
      subtitleKey: HomeKeys.discountSubtitle,
      // textPoint: context.l10n.saveMoney,
      title: context.l10n.discountsServices,
      subtitle: context.l10n.discountsServicesSubtitle,
      textButton: '${context.l10n.to[0].toUpperCase()}${context.l10n.to[1]}'
          ' ${context.l10n.toDiscounts}',
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
      buttonKey: HomeKeys.informationButton,
      // prefixKey: HomeKeys.informationPrefix,
      subtitleKey: HomeKeys.informationSubtitle,
      titleKey: HomeKeys.informationTitle,
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
