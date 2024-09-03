import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class NetworkStatusBanner extends SliverPersistentHeaderDelegate {
  const NetworkStatusBanner({
    required this.networkStatus,
  });
  final NetworkStatus networkStatus;

  @override
  double get maxExtent => KSize.kPixel36;

  @override
  double get minExtent => KSize.kPixel36;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return AnimatedOpacity(
      opacity:
          shrinkOffset < KSize.kPixel24 ? (1 - shrinkOffset / maxExtent) : 0,
      duration: const Duration(milliseconds: 500),
      child: _NetworkStatusBannerImplamentation(networkStatus: networkStatus),
    );
  }
}

class _NetworkStatusBannerImplamentation extends StatelessWidget {
  const _NetworkStatusBannerImplamentation({
    required this.networkStatus,
  });
  final NetworkStatus networkStatus;

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
