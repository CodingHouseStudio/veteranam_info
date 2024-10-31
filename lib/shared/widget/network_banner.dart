import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

// class NetworkStatusBanner extends SliverPersistentHeaderDelegate {
//   const NetworkStatusBanner({
//     required this.networkStatus,
//   });
//   final NetworkStatus networkStatus;

//   @override
//   double get maxExtent => KSize.kPixel36;

//   @override
//   double get minExtent => KSize.kPixel36;

//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
//       false;

//   @override
//   Widget build(
//     BuildContext context,
//     double shrinkOffset,
//     bool overlapsContent,
//   ) {
//     final progress = shrinkOffset / maxExtent;
//     return Stack(
//       fit: StackFit.expand,
//       children: [
//         AnimatedOpacity(
//           opacity: 1 - progress,
//           duration: const Duration(milliseconds: 300),
//           child: _NetworkStatusBannerImplamentation(
//             networkStatus: networkStatus,
//           ),
//         ),
//         AnimatedOpacity(
//           duration: const Duration(milliseconds: 150),
//           opacity: progress,
//           child: const Padding(
//             padding: EdgeInsets.only(
//               top: KPadding.kPaddingSize8,
//               right: KPadding.kPaddingSize8,
//             ),
//             child:
//                 Align(alignment: Alignment.topRight,
//child: KIcon.noInternet),
//           ),
//         ),
//       ],
//     );
//   }
// }

class NetworkStatusBanner extends StatefulWidget {
  const NetworkStatusBanner({
    required this.networkStatus,
    super.key,
  });
  final NetworkStatus networkStatus;

  @override
  State<NetworkStatusBanner> createState() => _NetworkStatusBannerState();

  static SliverPersistentHeaderDelegate getSliverHeader({
    required bool isDesk,
    required bool isTablet,
    Widget? childWidget,
    String? pageName,
    bool? showMobBackButton,
    NetworkStatus? networkStatus,
  }) =>
      SliverHeaderWidget(
        childWidget: ({required overlapsContent, required shrinkOffset}) {
          const maxMinHeight = KSize.kPixel36;
          final progress = shrinkOffset / maxMinHeight;
          return Stack(
            fit: StackFit.expand,
            children: [
              AnimatedOpacity(
                opacity: 1 - progress,
                duration: const Duration(milliseconds: 250),
                child: NetworkStatusBanner(
                  networkStatus: networkStatus!,
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: progress,
                child: const Padding(
                  padding: EdgeInsets.only(
                    top: KPadding.kPaddingSize20,
                    right: KPadding.kPaddingSize32,
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: KIcon.noInternet,
                  ),
                ),
              ),
            ],
          );
        },
        maxMinHeight: KSize.kPixel36,
      );
  // SliverHeaderWidget(
  //   childWidget: NetworkStatusBanner(
  //     networkStatus: networkStatus!,
  //   ),
  //   rebuildValues: [isDesk, isTablet],
  //   maxMinHeight: KSize.kPixel36,
  // );
}

class _NetworkStatusBannerState extends State<NetworkStatusBanner> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: KPadding.kPaddingSize10),
      child: Row(
        key: KWidgetkeys.widget.networkBanner.widget,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          KIcon.noInternet.copyWith(
            key: KWidgetkeys.widget.networkBanner.iconNoInternet,
          ),
          KSizedBox.kWidthSizedBox10,
          Text(
            context.l10n.noInternet,
            style: AppTextStyle.materialThemeLabelLarge.copyWith(
              color: AppColors.materialThemeSysLightError,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
