import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

part 'story_watcher_bloc.freezed.dart';
part 'story_watcher_event.dart';
part 'story_watcher_state.dart';

@Injectable(env: [Config.development])
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
      onError: (dynamic error, StackTrace stack) {
        // debugPrint('error is $error');
        add(StoryWatcherEvent.failure(error: error, stack: stack));
      },
    );
  }

  void _onUpdated(
    _Updated event,
    Emitter<StoryWatcherState> emit,
  ) {
    if (event.storyItemsModel.isEmpty && Config.isProduction) return;
    emit(
      StoryWatcherState(
        storyModelItems: event.storyItemsModel,
        loadingStatus: LoadingStatus.loaded,
        loadingStoryModelItems:
            event.storyItemsModel.loading(itemsLoaded: state.itemsLoaded),
        itemsLoaded: state.itemsLoaded.getLoaded(list: event.storyItemsModel),
        failure: null,
      ),
    );
  }

  void _onLoadNextItems(
    _LoadNextItems event,
    Emitter<StoryWatcherState> emit,
  ) {
    if (state.itemsLoaded.checkLoadingPosible(state.storyModelItems)) {
      emit(state.copyWith(loadingStatus: LoadingStatus.listLoadedFull));
      return;
    }
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));
    final filterItems = state.storyModelItems.loading(
      itemsLoaded: state.itemsLoaded,
      loadItems: KDimensions.loadItems,
    );

    emit(
      state.copyWith(
        loadingStoryModelItems: filterItems,
        itemsLoaded: filterItems.length,
        loadingStatus: state.storyModelItems.length <= filterItems.length
            ? LoadingStatus.listLoadedFull
            : LoadingStatus.loaded,
      ),
    );
  }

  void _onFailure(
    _Failure event,
    Emitter<StoryWatcherState> emit,
  ) {
    // debugPrint('error is ${event.failure}');
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.error,
        failure: SomeFailure.serverError(error: event.error, stack: event.stack)
            ._toStory(),
      ),
    );
  }

  @override
  Future<void> close() {
    _storyItemsSubscription?.cancel();
    return super.close();
  }
}
