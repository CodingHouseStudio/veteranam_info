import 'dart:async';
import 'dart:developer';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:dartz/dartz.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/constants/security_keys.dart';
import 'package:veteranam/shared/repositories/i_mobile_ads_repository.dart';
import 'package:veteranam/shared/shared_dart.dart';

@Singleton(as: IMobileAdsRepository)
class MobileAdsRepository extends IMobileAdsRepository {
  MobileAdsRepository({
    required FirebaseAnalyticsCacheController firebaseAnalyticsCacheController,
    required IAppLayoutRepository appLayoutRepository,
    required FirebaseRemoteConfigProvider firebaseRemoteConfigProvider,
  })  : _appLayoutRepository = appLayoutRepository,
        _firebaseAnalyticsCacheController = firebaseAnalyticsCacheController,
        _firebaseRemoteConfigProvider = firebaseRemoteConfigProvider;
  final IAppLayoutRepository _appLayoutRepository;
  final FirebaseAnalyticsCacheController _firebaseAnalyticsCacheController;
  final FirebaseRemoteConfigProvider _firebaseRemoteConfigProvider;
  AdRequest? request;

  static const showMobileAds = '__show_mobile_ads_key__';

  final adUnitId = PlatformEnum.getPlatform.isAndroid
      ? Config.isReleaseMode
          ? KSecurityKeys.androidBanerAdsID
          : 'ca-app-pub-3940256099942544/9214589741' // Google Ads test id
      : Config.isReleaseMode
          ? KSecurityKeys.iosBanerAdsID
          : 'ca-app-pub-3940256099942544/2435281174'; // Google Ads test id

  Future<void> _init() async {
    bool nonPersonalizedAds;
    try {
      await MobileAds.instance.initialize();

      if (PlatformEnum.getPlatform.isIOS) {
        final trackingStatus =
            await AppTrackingTransparency.trackingAuthorizationStatus;

        if (trackingStatus == TrackingStatus.authorized) {
          nonPersonalizedAds = false;
        } else {
          nonPersonalizedAds = true;
        }
      } else {
        nonPersonalizedAds = !_firebaseAnalyticsCacheController.currentState;
      }
    } catch (e) {
      nonPersonalizedAds = true;
    }
    request = AdRequest(
      keywords: ['знижки', 'ЗСУ', 'УБД'],
      contentUrl: 'https://veteranam.info/discounts',
      nonPersonalizedAds: nonPersonalizedAds,
    );
  }

  @override
  Future<Either<SomeFailure, BannerAd?>> loadBannerAd() async {
    return eitherFutureHelper(
      () async {
        await _firebaseRemoteConfigProvider.waitActivated();
        final show = _firebaseRemoteConfigProvider.getBool(showMobileAds);
        if (show) {
          if (request == null) await _init();
          if (PlatformEnum.getPlatform.isIOS) {}
          final size = _appLayoutRepository.getScreenSize;

          if (size == null) return const Right(null);

          final adSize =
              await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            size.width.truncate(),
          );
          if (adSize == null) return const Right(null);

          final bannerAd = BannerAd(
            adUnitId: adUnitId,
            request: request!,
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

          return Right(bannerAd);
        } else {
          return const Right(null);
        }
      },
      methodName: 'loadBannerAd',
      className: 'Mobile Ads ${ErrorText.repositoryKey}',
    );
  }
}
