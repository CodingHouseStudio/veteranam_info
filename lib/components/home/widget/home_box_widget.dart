import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kozak/shared/shared.dart';

class HomeBoxWidget extends StatelessWidget {
  const HomeBoxWidget({
    required this.isDesk,
    required this.aboutProjectKey,
    super.key,
  });
  final bool isDesk;
  final GlobalKey aboutProjectKey;

  @override
  Widget build(BuildContext context) {
    if (isDesk) {
      return IntrinsicHeight(
        key: KWidgetkeys.screen.home.box,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KSizedBox.kHeightSizedBox45,
                  Row(
                    children: [
                      Text(
                        context.l10n.hello,
                        key: KWidgetkeys.screen.home.boxHi,
                        style: AppTextStyle.materialThemeTitleMedium,
                      ),
                      KSizedBox.kWidthSizedBox8,
                      KImage.wavingHand,
                    ],
                  ),
                  KSizedBox.kHeightSizedBox16,
                  Text(
                    context.l10n.thisServiceForVeterans,
                    key: KWidgetkeys.screen.home.boxTitle,
                    style: AppTextStyle.text64,
                  ),
                  KSizedBox.kHeightSizedBox24,
                  Text(
                    context.l10n.thisServiceForVeteransSubtitle,
                    key: KWidgetkeys.screen.home.boxSubtitle,
                    style: AppTextStyle.materialThemeBodyLarge,
                  ),
                  KSizedBox.kHeightSizedBox16,
                  DoubleButtonWidget(
                    key: KWidgetkeys.screen.home.boxButton,
                    text: context.l10n.detail,
                    textColor: AppColors.materialThemeWhite,
                    color: AppColors.materialThemeBlack,
                    onPressed: () => Scrollable.ensureVisible(
                      aboutProjectKey.currentContext!,
                      duration: const Duration(microseconds: 1000),
                      curve: Curves.easeInOut,
                    ),
                  ),
                  KSizedBox.kHeightSizedBox45,
                ],
              ),
            ),
            const Expanded(child: KImage.homeImage),
          ],
        ),
      );
    } else {
      return Stack(
        key: KWidgetkeys.screen.home.box,
        alignment: Alignment.bottomRight,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: KPadding.kPaddingSize16,
                ),
                child: Text(
                  context.l10n.hello,
                  key: KWidgetkeys.screen.home.boxHi,
                  style: AppTextStyle.materialThemeTitleSmall,
                ),
              ),
              KSizedBox.kHeightSizedBox8,
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: KPadding.kPaddingSize16,
                ),
                child: Text(
                  context.l10n.thisServiceForVeterans,
                  key: KWidgetkeys.screen.home.boxTitle,
                  style: AppTextStyle.text36,
                ),
              ),
              KSizedBox.kHeightSizedBox8,
              Container(
                decoration: KWidgetTheme.boxDecorNeutralVariant,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KSizedBox.kHeightSizedBox8,
                    Padding(
                      padding: const EdgeInsets.only(
                        left: KPadding.kPaddingSize16,
                        right: KPadding.kPaddingSize120,
                      ),
                      child: Text(
                        context.l10n.thisServiceForVeteransSubtitle,
                        key: KWidgetkeys.screen.home.boxSubtitle,
                        style: AppTextStyle.materialThemeBodyMedium,
                      ),
                    ),
                    KSizedBox.kHeightSizedBox10,
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: KPadding.kPaddingSize16,
                      ),
                      alignment: Alignment.bottomLeft,
                      child: DoubleButtonWidget(
                        key: KWidgetkeys.screen.home.boxButton,
                        text: context.l10n.detail,
                        textColor: AppColors.materialThemeWhite,
                        color: AppColors.materialThemeBlack,
                        onPressed: null,
                      ),
                    ),
                    KSizedBox.kHeightSizedBox8,
                  ],
                ),
              ),
            ],
          ),
          KImage.homeImageMob,
        ],
      );
    }
  }
}
