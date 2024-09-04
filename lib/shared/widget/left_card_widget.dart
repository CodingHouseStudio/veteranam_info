// import 'package:flutter/material.dart';
// import 'package:veteranam/shared/shared.dart';

// class LeftCardWidget extends StatelessWidget {
//   const LeftCardWidget({
//     required this.widgetListFunction,
//     super.key,
//     this.image,
//   });

//   final List<Widget> Function({required bool isDesk}) widgetListFunction;
//   final String? image;
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final isDesk =
//             constraints.maxWidth > KPlatformConstants.minWidthThresholdDesk;
//         final isTablet =
//             constraints.maxWidth > 
// KPlatformConstants.minWidthThresholdTablet;
//         final widgetList = widgetListFunction(isDesk: isDesk);
//         return Scaffold(
//           backgroundColor:
//               isDesk ? AppColors.materialThemeKeyColorsNeutral : null,
//           body: CustomScrollView(
//             key: KWidgetkeys.widget.scaffold.scroll,
//             slivers: [
//               SliverPersistentHeader(
//                 delegate: NawbarWidget(isDesk: isDesk, isTablet: isTablet),
//               ),

//               SliverPadding(
//                 padding: isDesk
//                     ? const EdgeInsets.symmetric(
//                         vertical: KPadding.kPaddingSize40,
//                       )
//                     : const EdgeInsets.only(
//                         top: KPadding.kPaddingSize56,
//                         bottom: KPadding.kPaddingSize24,
//                         right: KPadding.kPaddingSize16,
//                         left: KPadding.kPaddingSize16,
//                       ),
//                 sliver: isDesk
//                     ? SliverPadding(
//                         padding: EdgeInsets.only(
//                           right: constraints.maxWidth *
//                               KDimensions.leftCardPaddingMultiply,
//                         ),
//                         sliver: DecoratedSliver(
//                           decoration: KWidgetTheme.boxDecorationWhite,
//                           sliver: SliverPadding(
//                             padding: const EdgeInsets.only(
//                               right: KPadding.kPaddingSize80,
//                               left: KPadding.kPaddingSize96,
//                               top: KPadding.kPaddingSize24,
//                               bottom: KPadding.kPaddingSize92,
//                             ),
//                             sliver: SliverList.builder(
//                               key: KWidgetkeys.widget.leftCard.desk,
//                               addAutomaticKeepAlives: false,
//                               addRepaintBoundaries: false,
//                               itemCount: widgetList.length,
//                               itemBuilder: (BuildContext context, 
//int index) =>
//                                   widgetList.elementAt(index),
//                             ),
//                           ),
//                         ),
//                       )
//                     : SliverList.builder(
//                         key: KWidgetkeys.widget.leftCard.mob,
//                         addAutomaticKeepAlives: false,
//                         addRepaintBoundaries: false,
//                         itemCount: widgetList.length,
//                         itemBuilder: (BuildContext context, int index) =>
//                             widgetList.elementAt(index),
//                       ),
//               ),
//               // Expanded(
//               //   child: image != null
//               //       ? ImageWidget(
//               //           key: KWidgetkeys.widget.leftCard.image,
//               //           imageUrl: KMockText.image,
//               //           fit: BoxFit.fill,
//               //         )
//               //       : const SizedBox.shrink(),
//               // ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
