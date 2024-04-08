import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
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
    on<_Updated>(_onUpdated);
    on<_Failure>(_onFailure);
  }
  final IHomeRepository _homeRepository;
  StreamSubscription<List<QuestionModel>>? _questionItemsSubscription;

  Future<void> _onStarted(
    _Started event,
    Emitter<HomeWatcherState> emit,
  ) async {
    emit(const HomeWatcherState.loading());

    await _questionItemsSubscription?.cancel();
    _questionItemsSubscription = _homeRepository.getQuestions().listen(
      (questionModelItems) {
        add(
          HomeWatcherEvent.updated(
            questionModelItems: questionModelItems,
          ),
        );
      },
      onError: (dynamic error) {
        debugPrint('error is $error');
        add(const HomeWatcherEvent.failure());
      },
    );
  }

  Future<void> _onUpdated(
    _Updated event,
    Emitter<HomeWatcherState> emit,
  ) async {
    emit(
      HomeWatcherState.success(questionModelItems: event.questionModelItems),
    );
  }

  void _onFailure(
    _Failure event,
    Emitter<HomeWatcherState> emit,
  ) {
    debugPrint('error is $event');
    emit(const HomeWatcherState.failure());
  }
}
