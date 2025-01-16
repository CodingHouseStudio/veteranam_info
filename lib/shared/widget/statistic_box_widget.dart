// import 'package:flutter/material.dart';
// import 'package:veteranam/shared/shared.dart';

// class StatisticBoxWidget extends StatelessWidget {
//   const StatisticBoxWidget({
//     required this.title,
//     required this.subtitle,
//     required this.onTap,
//     required this.isDesk,
//     super.key,
//     this.textRightPadding,
//     this.icon,
//   });

//   final String title;
//   final String subtitle;
//   final void Function()? onTap;
//   final bool isDesk;
//   final double? textRightPadding;
//   final Icon? icon;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(
//         top: KPadding.kPaddingSize8,
//         right: KPadding.kPaddingSize8,
//         bottom: isDesk ? KPadding.kPaddingSize24 : KPadding.kPaddingSize8,
//         left: isDesk ? KPadding.kPaddingSize24 : KPadding.kPaddingSize16,
//       ),
//       decoration: KWidgetTheme.boxDecorationCard,
//       child: isDesk
//           ? Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   key: StatisticBoxKeys.title,
//                   style: AppTextStyle.text40,
//                   maxLines: 1,
//                 ),
//                 Row(
//                   children: [
//                     KIcon.safe,
//                     Expanded(
//                       child: Text(
//                         subtitle,
//                         key: StatisticBoxKeys.subtitle,
//                         style: AppTextStyle.text16,
//                         maxLines: 1,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             )
//           : Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   key: StatisticBoxKeys.title,
//                   style: AppTextStyle.text24,
//                   maxLines: 1,
//                 ),
//                 Row(
//                   children: [
//                     KIcon.safe,
//                     Expanded(
//                       child: Text(
//                         subtitle,
//                         key: StatisticBoxKeys.subtitle,
//                         style: AppTextStyle.text14,
//                         maxLines: 1,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//     );
//   }
// }
