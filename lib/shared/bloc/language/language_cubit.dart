import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

@injectable
class LanguageCubit extends Cubit<Language> {
  LanguageCubit({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(
          userRepository.currentUserSetting.locale,
        );

  final UserRepository _userRepository;
  Timer? _timer;

  void started() {
    if (_userRepository.currentUserSetting.isEmpty) {
      var counter = 0;
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (_) {
          if (_userRepository.currentUserSetting.isNotEmpty || counter > 5) {
            emit(_userRepository.currentUserSetting.locale);
            _timer?.cancel();
          } else {
            counter++;
          }
        },
      );
    }
  }

  void languageChanged() {
    final value = state.isEnglish ? Language.ukrain : Language.english;
    unawaited(
      _userRepository.updateUserSetting(
        userSetting: _userRepository.currentUserSetting.copyWith(locale: value),
      ),
    );
    log('Language changed: $value');
    emit(value);
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
