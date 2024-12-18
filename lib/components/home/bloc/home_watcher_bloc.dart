import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

part 'home_watcher_bloc.freezed.dart';
part 'home_watcher_event.dart';
part 'home_watcher_state.dart';

@Injectable(env: [Config.user])
class HomeWatcherBloc extends Bloc<HomeWatcherEvent, HomeWatcherState> {
  HomeWatcherBloc({required IFaqRepository faqRepository})
      : _faqRepository = faqRepository,
        super(
          const HomeWatcherState(
            questionModelItems: [],
            loadingStatus: LoadingStatus.initial,
          ),
        ) {
    on<_Started>(_onStarted);
    add(const HomeWatcherEvent.started());
  }
  final IFaqRepository _faqRepository;

  Future<void> _onStarted(
    _Started event,
    Emitter<HomeWatcherState> emit,
  ) async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));

    final result = await _faqRepository.getQuestions();
    result.fold(
      (l) => emit(
        state.copyWith(
          failure: l._toHome(),
          loadingStatus: LoadingStatus.error,
        ),
      ),
      (r) => emit(
        HomeWatcherState(
          questionModelItems: r,
          loadingStatus: LoadingStatus.loaded,
        ),
      ),
    );
  }
}
