import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class NetworkBanner extends StatelessWidget {
  const NetworkBanner({
    // required this.isDesk,
    // required this.isTablet,
    super.key,
  });
  // final bool isDesk;
  // final bool isTablet;

  @override
  Widget build(BuildContext context) {
    if (!Config.isWeb) {
      return BlocBuilder<NetworkCubit, NetworkStatus>(
        builder: (context, state) {
          if (state.isOffline) {
            return SliverPersistentHeader(
              pinned: true,
              delegate: SliverHeaderWidget(
                childWidget: ({
                  required overlapsContent,
                  required shrinkOffset,
                }) {
                  const maxMinHeight = KSize.kPixel36;
                  final progress = shrinkOffset / maxMinHeight;
                  return RepaintBoundary(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        AnimatedOpacity(
                          opacity: 1 - progress,
                          duration: const Duration(milliseconds: 250),
                          child: _NetworkStatusBanner(
                            networkStatus: state,
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
                    ),
                  );
                },
                maxMinHeight: KSize.kPixel36,
              ),
            );
          }
          return const SliverToBoxAdapter();
        },
      );
    }
    return const SliverToBoxAdapter();
  }
}

class _NetworkStatusBanner extends StatefulWidget {
  const _NetworkStatusBanner({
    required this.networkStatus,
  });
  final NetworkStatus networkStatus;

  @override
  State<_NetworkStatusBanner> createState() => _NetworkStatusBannerState();
}

class _NetworkStatusBannerState extends State<_NetworkStatusBanner> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: KPadding.kPaddingSize10),
      child: Row(
        key: NetworkBannerKeys.widget,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: KPadding.kPaddingSize10,
        children: [
          KIcon.noInternet.copyWith(
            key: NetworkBannerKeys.iconNoInternet,
          ),
          Text(
            context.l10n.noInternet,
            style: AppTextStyle.materialThemeLabelLargeError,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
