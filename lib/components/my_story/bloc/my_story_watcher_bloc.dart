import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

part 'my_story_watcher_bloc.freezed.dart';
part 'my_story_watcher_event.dart';
part 'my_story_watcher_state.dart';

@Injectable(env: [Config.development])
class MyStoryWatcherBloc
    extends Bloc<MyStoryWatcherEvent, MyStoryWatcherState> {
  MyStoryWatcherBloc({
    required IStoryRepository storyRepository,
    required IAppAuthenticationRepository appAuthenticationRepository,
  })  : _storyRepository = storyRepository,
        _appAuthenticationRepository = appAuthenticationRepository,
        super(
          const MyStoryWatcherState(
            storyModelItems: [],
            loadingStatus: LoadingStatus.initial,
          ),
        ) {
    on<_Started>(_onStarted);
  }
  final IStoryRepository _storyRepository;
  final IAppAuthenticationRepository _appAuthenticationRepository;

  Future<void> _onStarted(
    _Started event,
    Emitter<MyStoryWatcherState> emit,
  ) async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));

    final result = await _storyRepository.getStoriesById(
      _appAuthenticationRepository.currentUser.id,
    );
    result.fold(
      (l) => emit(
        state.copyWith(
          failure: l._toMyStory(),
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
