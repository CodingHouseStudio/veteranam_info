import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/components/components.dart';
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
        super(const MyStoryWatcherState.initial()) {
    on<_Started>(_onStarted);
  }
  final IStoryRepository _storyRepository;
  final IAppAuthenticationRepository _iAppAuthenticationRepository;

  Future<void> _onStarted(
    _Started event,
    Emitter<MyStoryWatcherState> emit,
  ) async {
    emit(const MyStoryWatcherState.loading());

    // final result = await _storyRepository.getStoriesById(
    //   _iAppAuthenticationRepository.currentUser.id,
    // );
    // result.fold(
    //   (l) => emit(
    //     MyStoryWatcherState.failure(l.toMyStory()),
    //   ),
    //   (r) => emit(MyStoryWatcherState.success(storyModelItems: r)),
    // );
  }
}
