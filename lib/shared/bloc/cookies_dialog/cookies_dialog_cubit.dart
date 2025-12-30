import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:veteranam/shared/shared_dart.dart';

@injectable
class CookiesDialogCubit extends Cubit<bool> {
  CookiesDialogCubit({
    required FirebaseAnalyticsService firebaseAnalyticsService,
  })  : _firebaseAnalyticsService = firebaseAnalyticsService,
        super(false);

  final FirebaseAnalyticsService _firebaseAnalyticsService;

  void submitted({
    required bool onlyNecessary,
  }) {
    _firebaseAnalyticsService.setConsent(state: !onlyNecessary);

    emit(true);
  }
}
