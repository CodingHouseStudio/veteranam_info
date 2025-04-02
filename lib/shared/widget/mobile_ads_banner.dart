import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:veteranam/shared/bloc/mobile_ads/mobile_ads_cubit.dart';

class MobileAdsBanner extends StatelessWidget {
  const MobileAdsBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MobileAdsCubit, BannerAd?>(
      builder: (context, state) {
        if (state == null) {
          return const SliverToBoxAdapter();
        } else {
          return SliverToBoxAdapter(
            child: SizedBox(
              width: state.size.width.toDouble(),
              height: state.size.height.toDouble(),
              child: AdWidget(ad: state),
            ),
          );
        }
      },
    );
  }
}
