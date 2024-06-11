import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/shared/shared.dart';

part 'my_story_watcher_event.dart';
part 'my_story_watcher_state.dart';
part 'my_story_watcher_bloc.freezed.dart';

@Injectable()
class MyStoryWatcherBloc
    extends Bloc<MyStoryWatcherEvent, MyStoryWatcherState> {
  MyStoryWatcherBloc({
    required IStoryRepository storyRepository,
    required IAppAuthenticationRepository iAppAuthenticationRepository,
  })  : _storyRepository = storyRepository,
        _iAppAuthenticationRepository = iAppAuthenticationRepository,
        super(
          const MyStoryWatcherState(
            storyModelItems: [],
            loadingStatus: LoadingStatus.initial,
          ),
        ) {
    on<_Started>(_onStarted);
  }
  final IStoryRepository _storyRepository;
  final IAppAuthenticationRepository _iAppAuthenticationRepository;

  Future<void> _onStarted(
    _Started event,
    Emitter<MyStoryWatcherState> emit,
  ) async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));

    final result = await _storyRepository.getStoriesById(
      _iAppAuthenticationRepository.currentUser.id,
    );
    result.fold(
      (l) => emit(
        state.copyWith(
          failure: l.toMyStory(),
          loadingStatus: LoadingStatus.error,
        ),
      ),
      (r) => emit(
        MyStoryWatcherState(
          loadingStatus: LoadingStatus.loaded,
          storyModelItems: r,
        ),
      ),
    );
  }
}
