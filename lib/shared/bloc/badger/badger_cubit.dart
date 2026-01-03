import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

@injectable
class BadgerCubit extends Cubit<bool> {
  BadgerCubit({
    required SharedPrefencesProvider sharedPrefencesProvider,
  })  : _sharedPrefencesProvider = sharedPrefencesProvider,
        super(
          false,
        );
  final SharedPrefencesProvider _sharedPrefencesProvider;

  static const badgeCacheKey = '__badge_cache_key__';

  Future<void> removeBadge() async {
    final result = await valueFutureErrorHelper(
      () async {
        if (_sharedPrefencesProvider.getInt(badgeCacheKey) != null &&
            await FlutterAppBadger.isAppBadgeSupported()) {
          await FlutterAppBadger.removeBadge();
          await _sharedPrefencesProvider.remove(badgeCacheKey);
          return true;
        }
        return false;
      },
      failureValue: false,
      methodName: 'removeBadger',
      className: 'BadgeControllerWidget',
    );

    emit(result);
  }
}
