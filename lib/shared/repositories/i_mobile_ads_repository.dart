import 'package:dartz/dartz.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:veteranam/shared/shared_dart.dart';

// ignore: one_member_abstracts
abstract class IMobileAdsRepository {
  Future<Either<SomeFailure, BannerAd?>> loadBannerAd();
}
