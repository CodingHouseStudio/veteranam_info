import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:veteranam/shared/shared.dart';

class HomeBoxWidget extends StatelessWidget {
  HomeBoxWidget({
    required this.isDesk,
    required this.isTablet,
    required this.aboutProjectKey,
    super.key,
  });
  final bool isDesk;
  final bool isTablet;
  final GlobalKey aboutProjectKey;
  final homePageController = ScrollController();

  @override
  Widget build(BuildContext context) {
    if (isDesk || isTablet) {
      return Row(
        key: KWidgetkeys.screen.home.box,
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
                  style: AppTextStyle.h1,
                ),
                KSizedBox.kHeightSizedBox24,
                Text(
                  context.l10n.thisServiceForVeteransSubtitle,
                  key: KWidgetkeys.screen.home.boxSubtitle,
                  style: AppTextStyle.materialThemeBodyLarge,
                ),
                KSizedBox.kHeightSizedBox16,
                DoubleButtonWidget(
                  widgetKey: KWidgetkeys.screen.home.boxButton,
                  text: context.l10n.detail,
                  textColor: AppColors.materialThemeWhite,
                  color: AppColors.materialThemeKeyColorsSecondary,
                  onPressed: () => Scrollable.ensureVisible(
                    aboutProjectKey.currentContext!,
                    duration: const Duration(microseconds: 1000),
                    curve: Curves.easeInOut,
                  ),
                  isDesk: isDesk,
                ),
                KSizedBox.kHeightSizedBox45,
              ],
            ),
          ),
          // Expanded(
          //   child: ConstrainedBox(
          //     constraints:
          //         const BoxConstraints(maxHeight: KMinMaxSize.maxHeight400),
          //     child: isDesk
          //         ? Container(
          //             decoration: KWidgetTheme.boxDecorNeutralVariant,
          //             child: KImage.homeImage,
          //           )
          //         : ConstrainedBox(
          //             constraints: const BoxConstraints(
          //               maxHeight: KMinMaxSize.maxHeight400,
          //             ),
          //             child: KImage.homeImageMob,
          //           ),
          //   ),
          // ),
        ],
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
                child: Row(
                  children: [
                    Text(
                      context.l10n.hello,
                      key: KWidgetkeys.screen.home.boxHi,
                      style: AppTextStyle.materialThemeTitleSmall,
                    ),
                    KSizedBox.kWidthSizedBox8,
                    KImage.wavingHand,
                  ],
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
                  style: AppTextStyle.h1Mob,
                ),
              ),
              KSizedBox.kHeightSizedBox10,
              DecoratedBox(
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
                        widgetKey: KWidgetkeys.screen.home.boxButton,
                        text: context.l10n.detail,
                        textColor: AppColors.materialThemeWhite,
                        color: AppColors.materialThemeKeyColorsSecondary,
                        onPressed: () => Scrollable.ensureVisible(
                          aboutProjectKey.currentContext!,
                          duration: const Duration(microseconds: 1000),
                          curve: Curves.easeInOut,
                        ),
                        isDesk: isDesk,
                      ),
                    ),
                    KSizedBox.kHeightSizedBox8,
                  ],
                ),
              ),
            ],
          ),
          // KImage.logoHome,
          // ConstrainedBox(
          //   constraints:
          //       const BoxConstraints(maxHeight: KMinMaxSize.maxHeight220),
          //   child: KImage.homeImageMob,
          // ),
        ],
      );
    }
  }
}
