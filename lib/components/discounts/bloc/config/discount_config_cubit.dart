import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart'
    show visibleForTesting;
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

part 'discount_config_state.dart';

@Injectable(env: [Config.user])
class DiscountConfigCubit extends Cubit<DiscountConfigState> {
  DiscountConfigCubit({
    required FirebaseRemoteConfigProvider firebaseRemoteConfigProvider,
  })  : _firebaseRemoteConfigProvider = firebaseRemoteConfigProvider,
        super(
          const DiscountConfigState(
            emailScrollCount: KDimensions.emailScrollCount,
            loadingItems: KDimensions.loadItems,
            linkScrollCount: KDimensions.linkScrollCount,
            emailCloseDelay: KDimensions.emailCloseDelay,
            mobFilterEnhancedMobile: true,
            enableVerticalDiscount: true,
            mobileShowCount: true,
          ),
        ) {
    _started();
  }

  final FirebaseRemoteConfigProvider _firebaseRemoteConfigProvider;

  @visibleForTesting
  static const emailScrollKey = '__email_scroll_count_key__';
  @visibleForTesting
  static const linkScrollKey = '__link_scroll_count_key__';
  @visibleForTesting
  static const emailCloseDelayKey = '__email_close_delay_count_key__';
  @visibleForTesting
  static const mobFilterEnhancedMobileKey = '__mob_filter_enhanced_mobile__';
  @visibleForTesting
  static const enableVerticalDiscountKey =
      '__discount_enable_vertical_list_key__';
  @visibleForTesting
  static const filterShowCountKey = '__discount_mobile_filter_show_count_key__';

  static const loadingItemsKey = '__discount_loading_items_count_key__';

  Future<void> _started() async {
    // Wait for initialize remote config if it didn't happen yet
    await _firebaseRemoteConfigProvider.waitActivated();

    final emailScrollCount =
        _firebaseRemoteConfigProvider.getInt(emailScrollKey);
    final linkScrollCount = _firebaseRemoteConfigProvider.getInt(linkScrollKey);
    final loadingItems = _firebaseRemoteConfigProvider.getInt(loadingItemsKey);
    final emailCloseDelay =
        _firebaseRemoteConfigProvider.getInt(emailCloseDelayKey);
    final mobFilterEnhancedMobile =
        _firebaseRemoteConfigProvider.getBool(mobFilterEnhancedMobileKey);
    final enableVerticalDiscount =
        _firebaseRemoteConfigProvider.getBool(enableVerticalDiscountKey);
    final mobileFilterShowCount =
        _firebaseRemoteConfigProvider.getBool(filterShowCountKey);
    if (!isClosed) {
      emit(
        DiscountConfigState(
          emailScrollCount: emailScrollCount > 0
              ? emailScrollCount
              : KDimensions.emailScrollCount,
          loadingItems: loadingItems > 0 ? loadingItems : KDimensions.loadItems,
          linkScrollCount: linkScrollCount > 0
              ? linkScrollCount
              : KDimensions.linkScrollCount,
          emailCloseDelay: emailCloseDelay > 0
              ? emailCloseDelay
              : KDimensions.emailCloseDelay,
          mobFilterEnhancedMobile: mobFilterEnhancedMobile,
          enableVerticalDiscount: enableVerticalDiscount,
          mobileShowCount: mobileFilterShowCount,
        ),
      );
    }
  }
}

//  emailScrollCount == 0
//             ? KDimensions.emailScrollCount
//             : emailScrollCount
