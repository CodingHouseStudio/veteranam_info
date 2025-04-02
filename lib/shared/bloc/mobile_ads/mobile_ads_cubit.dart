import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

const testDevice = 'test';

@injectable
class MobileAdsCubit extends Cubit<BannerAd?> {
  MobileAdsCubit({
    required FirebaseAnalyticsCacheController firebaseAnalyticsCacheController,
    required IAppLayoutRepository appLayoutRepository,
  })  : _firebaseAnalyticsCacheController = firebaseAnalyticsCacheController,
        _appLayoutRepository = appLayoutRepository,
        request = AdRequest(
          keywords: ['foo', 'bar'],
          contentUrl: 'http://foo.com/bar.html',
          nonPersonalizedAds: firebaseAnalyticsCacheController.currentState,
        ),
        super(null) {
    _initial();
  }
  final FirebaseAnalyticsCacheController _firebaseAnalyticsCacheController;
  final IAppLayoutRepository _appLayoutRepository;
  final AdRequest request;

  // TODO: replace this test ad unit with your own ad unit.
  final adUnitId = PlatformEnum.getPlatform.isAndroid
      ? 'ca-app-pub-3940256099942544/9214589741'
      : 'ca-app-pub-3940256099942544/2435281174';

  Future<void> _initial() async {
    await MobileAds.instance.updateRequestConfiguration(
      RequestConfiguration(
        testDeviceIds: [testDevice],
      ),
    );

    final size = _appLayoutRepository.getScreenSize;

    if (size == null) return;

    final adSize =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
      size.width.truncate(),
    );
    if (adSize == null) return;

    final bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: adSize,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          log('$ad loaded.');
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          log('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
      ),
    );
    await bannerAd.load();
    emit(bannerAd);
  }
}
