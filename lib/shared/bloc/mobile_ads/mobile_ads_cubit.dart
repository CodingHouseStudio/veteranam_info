import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:injectable/injectable.dart';

import 'package:veteranam/shared/repositories/i_mobile_ads_repository.dart';

@injectable
class MobileAdsCubit extends Cubit<BannerAd?> {
  MobileAdsCubit({
    required IMobileAdsRepository mobileAdsRepository,
  })  : _mobileAdsRepository = mobileAdsRepository,
        super(null) {
    _initial();
  }
  final IMobileAdsRepository _mobileAdsRepository;

  Future<void> _initial() async {
    final result = await _mobileAdsRepository.loadBannerAd();

    result.fold(
      Left.new,
      emit,
    );
  }
}
