import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/shared/shared.dart';

part 'home_watcher_event.dart';
part 'home_watcher_state.dart';
part 'home_watcher_bloc.freezed.dart';

@Injectable()
class HomeWatcherBloc extends Bloc<HomeWatcherEvent, HomeWatcherState> {
  HomeWatcherBloc({required IHomeRepository homeRepository})
      : _homeRepository = homeRepository,
        super(
          const HomeWatcherState(
            questionModelItems: [],
            loadingStatus: LoadingStatus.initial,
          ),
        ) {
    on<_Started>(_onStarted);
  }
  final IHomeRepository _homeRepository;

  Future<void> _onStarted(
    _Started event,
    Emitter<HomeWatcherState> emit,
  ) async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));

    final result = await _homeRepository.getQuestions();
    result.fold(
      (l) => emit(
        state.copyWith(failure: l.toHome(), loadingStatus: LoadingStatus.error),
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
