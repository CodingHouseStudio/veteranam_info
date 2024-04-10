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
        super(const HomeWatcherState.initial()) {
    on<_Started>(_onStarted);
  }
  final IHomeRepository _homeRepository;

  Future<void> _onStarted(
    _Started event,
    Emitter<HomeWatcherState> emit,
  ) async {
    emit(const HomeWatcherState.loading());

    try {
      final result = _homeRepository.getQuestions();
      emit(HomeWatcherState.success(questionModelItems: result));
    } catch (e) {
      emit(const HomeWatcherState.failure());
    }
  }
}
