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
          ),
        );

  final FirebaseRemoteConfigProvider _firebaseRemoteConfigProvider;

  @visibleForTesting
  static const emailScrollKey = '__email_scroll_count_key__';
  @visibleForTesting
  static const linkScrollKey = '__link_scroll_count_key__';
  @visibleForTesting
  static const emailCloseDelayKey = '__email_close_delay_count_key__';

  static const loadingItemsKey = '__discount_loading_items_count_key__';
  void started() {
    final emailScrollCount =
        _firebaseRemoteConfigProvider.getInt(emailScrollKey);
    final linkScrollCount = _firebaseRemoteConfigProvider.getInt(linkScrollKey);
    final loadingItems = _firebaseRemoteConfigProvider.getInt(loadingItemsKey);
    final emailCloseDelay =
        _firebaseRemoteConfigProvider.getInt(emailCloseDelayKey);
    emit(
      DiscountConfigState(
        emailScrollCount: emailScrollCount > 0
            ? emailScrollCount
            : KDimensions.emailScrollCount,
        loadingItems: loadingItems > 0 ? loadingItems : KDimensions.loadItems,
        linkScrollCount:
            linkScrollCount > 0 ? linkScrollCount : KDimensions.linkScrollCount,
        emailCloseDelay:
            emailCloseDelay > 0 ? emailCloseDelay : KDimensions.emailCloseDelay,
      ),
    );
  }
}

//  emailScrollCount == 0
//             ? KDimensions.emailScrollCount
//             : emailScrollCount
