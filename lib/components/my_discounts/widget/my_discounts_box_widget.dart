part of 'body/my_discounts_body_widget.dart';

List<Widget> _boxWidgetList({
  required BuildContext context,
  required bool isDesk,
}) => List.generate(context.read<MyDiscountsWatcherBloc>().state, (index) {
          return
      IntrinsicHeight(
      child: Column(
        children:  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  DiscountsCardWidget(
                    key: KWidgetkeys.screen.myDiscounts.card,
                    discountItem: discountItems.first,
                    isDesk: isDesk,
                  ),
                  // BoxWidget(
                  //   text: context.l10n.statistics,
                  //   isDesk: isDesk,
                  //   textIconPaddingWidget: KSizedBox.kHeightSizedBox56,
                  //   onTap: null,
                  // ),
                ],
              ),
            ),
            KSizedBox.kWidthSizedBox24,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    IconWidget(
                      padding: KPadding.kPaddingSize12,
                      icon: KIcon.trash,
                      background:
                          AppColors.materialThemeKeyColorsNeutralVariant,
                    ),
                    KSizedBox.kWidthSizedBox8,
                    IconWidget(
                      padding: KPadding.kPaddingSize12,
                      icon: KIcon.edit,
                      background:
                          AppColors.materialThemeKeyColorsNeutralVariant,
                    ),
                    KSizedBox.kWidthSizedBox8,
                    IconWidget(
                      padding: KPadding.kPaddingSize12,
                      icon: KIcon.share,
                      background:
                          AppColors.materialThemeKeyColorsNeutralVariant,
                    ),
                  ],
                ),
                KSizedBox.kHeightSizedBox16,
                TextButton.icon(
                  onPressed: null,
                  style: KButtonStyles.borderButtonStyle,
                  icon: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: KPadding.kPaddingSize12,
                    ).copyWith(
                      left: KPadding.kPaddingSize22,
                    ),
                    child: KIcon.close,
                  ),
                  label: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: KPadding.kPaddingSize16,
                      ),
                      child: Text(
                        key: KWidgetkeys.screen.employeeRespond.upload,
                        context.l10n.deactivate,
                        style: AppTextStyle.text24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            KSizedBox.kHeightSizedBox24,
          ]);
          //],
        
      ),
    );
});
//key: ,
//   child: Row(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       DiscountsCardWidget(
//         key: KWidgetkeys.screen.myDiscounts.card,
//         discountItem: discountItems,
//         isDesk: isDesk,
//       ),
//       Column(
//         children: [
//           const Row(
//             children: [
//               IconWidget(
//                 padding: KPadding.kPaddingSize20,
//                 icon: KIcon.trash,
//               ),
//               IconWidget(
//                 padding: KPadding.kPaddingSize20,
//                 icon: KIcon.edit,
//               ),
//               IconWidget(
//                 padding: KPadding.kPaddingSize20,
//                 icon: KIcon.share,
//               ),
//             ],
//           ),
//           TextButton.icon(
//             onPressed: null,
//             style: KButtonStyles.borderButtonStyle,
//             icon: Padding(
//               padding: EdgeInsets.symmetric(
//                 vertical: isDesk
//                     ? KPadding.kPaddingSize32
//                     : KPadding.kPaddingSize16,
//               ).copyWith(
//                 left: isDesk
//                     ? KPadding.kPaddingSize16
//                     : KPadding.kPaddingSize8,
//               ),
//               child: KIcon.close,
//             ),
//             label: Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 key: KWidgetkeys.screen.employeeRespond.upload,
//                 context.l10n.deactivate,
//                 style: isDesk
//                     ? AppTextStyle.text24.copyWith(
//                         decoration: TextDecoration.underline,
//                       )
//                     : AppTextStyle.text16.copyWith(
//                         decoration: TextDecoration.underline,
//                       ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     ],
//   ),
// );
//} else {
//     return Stack(
//       key: KWidgetkeys.screen.home.box,
//       alignment: Alignment.bottomRight,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: KPadding.kPaddingSize16,
//               ),
//               child: Text(
//                 context.l10n.hello,
//                 key: KWidgetkeys.screen.home.boxHi,
//                 style: AppTextStyle.materialThemeTitleSmall,
//               ),
//             ),
//             KSizedBox.kHeightSizedBox8,
//           ],
//         ),
//         KImage.homeImageMob,
//       ],
//     );
//   }
//}
//}
