import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

@injectable
class AppLayoutCubit extends Cubit<AppVersionEnum> {
  AppLayoutCubit({
    required IAppLayoutRepository appLayoutRepository,
  })  : _appLayoutRepository = appLayoutRepository,
        super(appLayoutRepository.getCurrentAppVersion) {
    _init();
  }
  final IAppLayoutRepository _appLayoutRepository;
  StreamSubscription<AppVersionEnum>? _subscription;

  void _init() {
    _subscription = _appLayoutRepository.sizeStream.listen(
      _layoutChange,
      onError: (Object error, StackTrace stack) =>
          _error(error: error, stack: stack),
    );
  }

  void _layoutChange(AppVersionEnum appVersionEnum) {
    if (appVersionEnum != state) {
      emit(appVersionEnum);
    }
  }

  void _error({
    required Object error,
    required StackTrace stack,
  }) {
    SomeFailure.value(
      error: error,
      stack: stack,
      tag: 'App Layout Cubit(Screen Size)',
      tagKey: ErrorText.streamBlocKey,
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    _appLayoutRepository.dispose();
    return super.close();
  }
}
