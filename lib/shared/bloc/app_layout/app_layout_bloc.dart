import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

part 'app_layout_event.dart';
part 'app_layout_state.dart';

@singleton
class AppLayoutBloc extends Bloc<_AppLayoutEvent, AppLayoutState> {
  AppLayoutBloc({
    required IAppLayoutRepository appLayoutRepository,
  })  : _appLayoutRepository = appLayoutRepository,
        super(
          AppLayoutState._(
            appVersionEnum: appLayoutRepository.getCurrentAppVersion,
          ),
        ) {
    on<_AppVersionChanged>(_onLayoutChange);
    on<_AppVersionFailureEvent>(_onAppVersionFailureEvent);
    _init();
  }
  final IAppLayoutRepository _appLayoutRepository;
  StreamSubscription<AppVersionEnum>? _subscription;

  void _init() {
    _subscription = _appLayoutRepository.appVersionStream.listen(
      (appVersionEnum) => add(_AppVersionChanged(appVersionEnum)),
      onError: (Object error, StackTrace stack) =>
          add(_AppVersionFailureEvent(stack: stack, error: error)),
    );
  }

  void _onLayoutChange(
    _AppVersionChanged event,
    Emitter<AppLayoutState> emit,
  ) {
    if (event.appVersionEnum != state.appVersionEnum) {
      switch (event.appVersionEnum) {
        case AppVersionEnum.desk:
          emit(const AppLayoutState.desk());
        case AppVersionEnum.mobile:
          emit(const AppLayoutState.mob());
        case AppVersionEnum.tablet:
          emit(const AppLayoutState.tablet());
      }
    }
  }

  void _onAppVersionFailureEvent(
    _AppVersionFailureEvent event,
    Emitter<AppLayoutState> emit,
  ) {
    emit(
      AppLayoutState.failure(
        failure: SomeFailure.value(
          error: event.error,
          stack: event.stack,
          tag: 'App Layout Cubit(Screen Size)',
          tagKey: ErrorText.streamBlocKey,
        ),
        previousAppVersion: state.appVersionEnum,
      ),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    _appLayoutRepository.dispose();
    return super.close();
  }
}
