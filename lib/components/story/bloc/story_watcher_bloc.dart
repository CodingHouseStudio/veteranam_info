import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/shared/shared.dart';

part 'story_watcher_event.dart';
part 'story_watcher_state.dart';
part 'story_watcher_bloc.freezed.dart';

@Injectable()
class StoryWatcherBloc extends Bloc<StoryWatcherEvent, StoryWatcherState> {
  StoryWatcherBloc({required IStoryRepository storyRepository})
      : _storyRepository = storyRepository,
        super(
          const _Initial(
            storyModelItems: [],
            loadingStatus: LoadingStatus.initial,
            loadingStoryModelItems: [],
            itemsLoaded: 0,
            failure: null,
          ),
        ) {
    on<_Started>(_onStarted);
    on<_Updated>(_onUpdated);
    on<_Failure>(_onFailure);
    on<_LoadNextItems>(_onLoadNextItems);
  }
  final IStoryRepository _storyRepository;
  StreamSubscription<List<StoryModel>>? _storyItemsSubscription;

  Future<void> _onStarted(
    _Started event,
    Emitter<StoryWatcherState> emit,
  ) async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));

    await _storyItemsSubscription?.cancel();
    _storyItemsSubscription = _storyRepository.getStoryItems().listen(
      (story) => add(
        StoryWatcherEvent.updated(
          story,
        ),
      ),
      onError: (dynamic error) {
        debugPrint('error is $error');
        add(StoryWatcherEvent.failure(error));
      },
    );
  }

  void _onUpdated(
    _Updated event,
    Emitter<StoryWatcherState> emit,
  ) {
    final itemsLoaded = event.storyItemsModel.isNotEmpty
        ? state.itemsLoaded != 0
            ? event.storyItemsModel.length > state.itemsLoaded
                ? state.itemsLoaded
                : event.storyItemsModel.length
            : KDimensions.loadItems
        : 0;
    emit(
      StoryWatcherState(
        storyModelItems: event.storyItemsModel,
        loadingStatus: LoadingStatus.loaded,
        loadingStoryModelItems: event.storyItemsModel.sublist(0, itemsLoaded),
        itemsLoaded: itemsLoaded,
        failure: null,
      ),
    );
  }

  void _onLoadNextItems(
    _LoadNextItems event,
    Emitter<StoryWatcherState> emit,
  ) {
    if (state.itemsLoaded + KDimensions.loadItems >
        state.storyModelItems.length) return;

    emit(
      state.copyWith(
        loadingStoryModelItems: state.storyModelItems
            .sublist(0, state.itemsLoaded + KDimensions.loadItems),
        itemsLoaded: state.itemsLoaded + KDimensions.loadItems,
      ),
    );
  }

  void _onFailure(
    _Failure event,
    Emitter<StoryWatcherState> emit,
  ) {
    debugPrint('error is ${event.failure}');
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.error,
        failure: GetFailur.fromCode(event.failure).status.toStory(),
      ),
    );
  }

  @override
  Future<void> close() {
    _storyItemsSubscription?.cancel();
    return super.close();
  }
}
