import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class NetworkStatusBanner extends SliverPersistentHeaderDelegate {
  const NetworkStatusBanner({
    required this.networkStatus,
  });
  final NetworkStatus networkStatus;

  @override
  double get maxExtent => KSize.kFont30;

  @override
  double get minExtent => KSize.kFont30;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return AnimatedOpacity(
      opacity:
          shrinkOffset < KSize.kFont20 ? (1 - shrinkOffset / maxExtent) : 0,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            key: KWidgetkeys.widget.networkBanner.widget,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (networkStatus.isOffline)
                Container(
                  key: KWidgetkeys.widget.networkBanner.iconNoInternet,
                  child: KIcon.noInternet,
                )
              else
                Container(
                  key: KWidgetkeys.widget.networkBanner.iconSlowInternet,
                  child: KIcon.slowInternet,
                ),
              KSizedBox.kWidthSizedBox10,
              Flexible(
                child: Text(
                  networkStatus.isOffline
                      ? context.l10n.noInternet
                      : context.l10n.slowInternet,
                  style: AppTextStyle.materialThemeLabelMedium.copyWith(
                    color: networkStatus.isOffline
                        ? AppColors.materialThemeSysLightError
                        : Colors.orange,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
