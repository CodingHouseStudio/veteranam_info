import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:veteranam/shared/shared.dart';

class HomeBoxWidget extends StatelessWidget {
  const HomeBoxWidget({
    required this.isDesk,
    required this.aboutProjectKey,
    required this.isTablet,
    super.key,
  });
  final bool isDesk;
  final bool isTablet;
  final GlobalKey aboutProjectKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: KWidgetkeys.screen.home.box,
      padding: EdgeInsets.all(
        isTablet ? KPadding.kPaddingSize40 : KPadding.kPaddingSize16,
      ),
      decoration: KWidgetTheme.boxDecorationHome,
      child: Column(
        crossAxisAlignment:
            isTablet ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Text(
            context.l10n.thankYouVeterans,
            key: KWidgetkeys.screen.home.boxTitle,
            style: isDesk
                ? AppTextStyle.h1
                : isTablet
                    ? AppTextStyle.h1Tablet
                    : AppTextStyle.h1Mob,
            textAlign: isTablet ? null : TextAlign.center,
          ),
          if (isDesk)
            KSizedBox.kHeightSizedBox24
          else
            KSizedBox.kHeightSizedBox16,
          Text(
            context.l10n.homeSubtitle,
            key: KWidgetkeys.screen.home.boxSubtitle,
            style: isDesk
                ? AppTextStyle.materialThemeTitleLarge
                : AppTextStyle.materialThemeBodyLarge,
          ),
          if (isDesk)
            KSizedBox.kHeightSizedBox24
          else
            KSizedBox.kHeightSizedBox16,
          DoubleButtonWidget(
            widgetKey: KWidgetkeys.screen.home.boxButton,
            text: context.l10n.detail,
            onPressed: () => Scrollable.ensureVisible(
              aboutProjectKey.currentContext!,
              duration: const Duration(microseconds: 1000),
              curve: Curves.easeInOut,
            ),
            isDesk: isDesk,
            align: isTablet ? null : Alignment.center,
          ),
          if (isDesk) KSizedBox.kHeightSizedBox40,
          // Row(
          //   children: [
          //     Expanded(
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           KSizedBox.kHeightSizedBox45,
          //           Row(
          //             children: [
          //               Text(
          //                 context.l10n.hello,
          //                 key: KWidgetkeys.screen.home.boxHi,
          //                 style: AppTextStyle.materialThemeTitleMedium,
          //               ),
          //               KSizedBox.kWidthSizedBox8,
          //               KImage.wavingHand(),
          //             ],
          //           ),
          //           KSizedBox.kHeightSizedBox24,
          //           Text(
          //             context.l10n.thisServiceForVeteransSubtitle,
          //             key: KWidgetkeys.screen.home.boxSubtitle,
          //             style: AppTextStyle.materialThemeBodyLarge,
          //           ),
          //           KSizedBox.kHeightSizedBox16,
          //           DoubleButtonWidget(
          //             widgetKey: KWidgetkeys.screen.home.boxButton,
          //             text: context.l10n.detail,
          //             textColor: AppColors.materialThemeWhite,
          //             color: AppColors.materialThemeKeyColorsSecondary,
          //             onPressed: () => Scrollable.ensureVisible(
          //               aboutProjectKey.currentContext!,
          //               duration: const Duration(microseconds: 1000),
          //               curve: Curves.easeInOut,
          //             ),
          //             isDesk: isDesk,
          //           ),
          //           KSizedBox.kHeightSizedBox45,
          //         ],
          //       ),
          //     ),
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
          //   ],
          // ),
        ],
      ),
    );

    //  else {
    //   return Stack(
    //     key: KWidgetkeys.screen.home.box,
    //     alignment: Alignment.bottomRight,
    //     children: [
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.symmetric(
    //               horizontal: KPadding.kPaddingSize16,
    //             ),
    //             child: Row(
    //               children: [
    //                 Text(
    //                   context.l10n.hello,
    //                   key: KWidgetkeys.screen.home.boxHi,
    //                   style: AppTextStyle.materialThemeTitleSmall,
    //                 ),
    //                 KSizedBox.kWidthSizedBox8,
    //                 KImage.wavingHand(),
    //               ],
    //             ),
    //           ),
    //           KSizedBox.kHeightSizedBox8,
    // Padding(
    //   padding: const EdgeInsets.symmetric(
    //     horizontal: KPadding.kPaddingSize16,
    //   ),
    //   child: Text(
    //     context.l10n.thisServiceForVeterans,
    //     key: KWidgetkeys.screen.home.boxTitle,
    //     style: AppTextStyle.h1Mob,
    //   ),
    // ),
    //           KSizedBox.kHeightSizedBox10,
    //           DecoratedBox(
    //             decoration: KWidgetTheme.boxDecorNeutralVariant,
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 KSizedBox.kHeightSizedBox8,
    //                 Padding(
    //                   padding: const EdgeInsets.only(
    //                     left: KPadding.kPaddingSize16,
    //                     right: KPadding.kPaddingSize120,
    //                   ),
    //                   child: Text(
    //                     context.l10n.thisServiceForVeteransSubtitle,
    //                     key: KWidgetkeys.screen.home.boxSubtitle,
    //                     style: AppTextStyle.materialThemeBodyMedium,
    //                   ),
    //                 ),
    //                 KSizedBox.kHeightSizedBox10,
    //                 Container(
    //                   padding: const EdgeInsets.symmetric(
    //                     horizontal: KPadding.kPaddingSize16,
    //                   ),
    //                   alignment: Alignment.bottomLeft,
    //                   child: DoubleButtonWidget(
    //                     widgetKey: KWidgetkeys.screen.home.boxButton,
    //                     text: context.l10n.detail,
    //                     textColor: AppColors.materialThemeWhite,
    //                     color: AppColors.materialThemeKeyColorsSecondary,
    //                     onPressed: () => Scrollable.ensureVisible(
    //                       aboutProjectKey.currentContext!,
    //                       duration: const Duration(microseconds: 1000),
    //                       curve: Curves.easeInOut,
    //                     ),
    //                     isDesk: isDesk,
    //                   ),
    //                 ),
    //                 KSizedBox.kHeightSizedBox8,
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    // KImage.logoHome,
    // ConstrainedBox(
    //   constraints:
    //       const BoxConstraints(maxHeight: KMinMaxSize.maxHeight220),
    //   child: KImage.homeImageMob,
    // ),
    //     ],
    //   );
    // }
  }
}
