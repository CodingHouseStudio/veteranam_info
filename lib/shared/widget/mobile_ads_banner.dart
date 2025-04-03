import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class MobileAdsBanner extends StatelessWidget {
  const MobileAdsBanner({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO(test): change in future
    if (KTest.isTest) {
      return const SliverToBoxAdapter();
    }
    return BlocBuilder<MobileAdsCubit, BannerAd?>(
      builder: (context, state) {
        if (state == null) {
          return const SliverToBoxAdapter();
        } else {
          final width = state.size.width.toDouble();
          final height = state.size.height.toDouble();
          return SliverPersistentHeader(
            pinned: true,
            delegate: SliverHeaderWidget(
              childWidget: ({
                required overlapsContent,
                required shrinkOffset,
              }) =>
                  SizedBox(
                width: width,
                height: height,
                child: AdWidget(ad: state),
              ),
              maxMinHeight: height,
            ),
          );
        }
      },
    );
  }
}
