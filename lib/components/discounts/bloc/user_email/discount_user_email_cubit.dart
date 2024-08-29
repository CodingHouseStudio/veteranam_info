import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

@Injectable()
class DiscountUserEmailCubit extends Cubit<DiscountUserEmailState> {
  DiscountUserEmailCubit({
    required IDiscountRepository discountRepository,
    required IAppAuthenticationRepository appAuthenticationRepository,
    required FirebaseRemoteConfigProvider firebaseRemoteConfigProvider,
  })  : _discountRepository = discountRepository,
        _appAuthenticationRepository = appAuthenticationRepository,
        _firebaseRemoteConfigProvider = firebaseRemoteConfigProvider,
        super(
          const DiscountUserEmailState(
            show: true,
            emailScrollCount: KDimensions.emailScrollCount,
          ),
        );
  final IDiscountRepository _discountRepository;
  final IAppAuthenticationRepository _appAuthenticationRepository;
  final FirebaseRemoteConfigProvider _firebaseRemoteConfigProvider;

  @visibleForTesting
  static const emailScrollKey = '__email_scroll_count_key__';

  Future<void> started() async {
    final result = await _discountRepository
        .userCanSendUserEmail(_appAuthenticationRepository.currentUser.id);
    final emailScrollCount =
        _firebaseRemoteConfigProvider.getInt(emailScrollKey);
    late bool show;
    result.fold(
      (l) => show = false,
      (r) => show = r,
    );

    emit(
      DiscountUserEmailState(
        show: show,
        emailScrollCount: emailScrollCount == 0
            ? KDimensions.emailScrollCount
            : emailScrollCount,
      ),
    );
  }
}

// I think it's bad idea to use here recored. It'll be not comfortable for tests
// because I create a very simple state
class DiscountUserEmailState extends Equatable {
  const DiscountUserEmailState({
    required this.show,
    required this.emailScrollCount,
  });
  final bool show;
  final int emailScrollCount;

  @override
  List<Object?> get props => [show, emailScrollCount];
}
