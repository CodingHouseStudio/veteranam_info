import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.story} ${KGroupText.bloc}', () {
    late StoryWatcherBloc storyWatcherBloc;
    late IStoryRepository mockStoryRepository;

    setUp(() {
      mockStoryRepository = MockIStoryRepository();
      storyWatcherBloc = StoryWatcherBloc(
        storyRepository: mockStoryRepository,
      );
    });

    blocTest<StoryWatcherBloc, StoryWatcherState>(
      'emits [StoryWatcherState()]'
      ' when load StoryModel list',
      build: () => storyWatcherBloc,
      act: (bloc) async {
        when(mockStoryRepository.getStoryItems()).thenAnswer(
          (_) => Stream.value(KTestText.storyModelItems),
        );
        bloc.add(const StoryWatcherEvent.started());
      },
      expect: () async => [
        predicate<StoryWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<StoryWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loaded,
        ),
      ],
    );
    blocTest<StoryWatcherBloc, StoryWatcherState>(
      'emits [StoryWatcherState()] when error',
      build: () => storyWatcherBloc,
      act: (bloc) async {
        when(mockStoryRepository.getStoryItems()).thenAnswer(
          (_) => Stream.error(KGroupText.failureGet),
        );
        bloc.add(const StoryWatcherEvent.started());
      },
      expect: () async => [
        predicate<StoryWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<StoryWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.error &&
              state.failure != null,
        ),
      ],
    );

    blocTest<StoryWatcherBloc, StoryWatcherState>(
      'emits [StoryWatcherState()]'
      ' when load StoryModel list and loadNextItems it',
      build: () => storyWatcherBloc,
      act: (bloc) async {
        when(mockStoryRepository.getStoryItems()).thenAnswer(
          (_) => Stream.value(KTestText.storyModelItems),
        );
        bloc.add(const StoryWatcherEvent.started());
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<StoryWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loading,
            ),
            predicate<StoryWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loaded,
            ),
          ]),
          reason: 'Wait loading data',
        );
        bloc.add(
          const StoryWatcherEvent.loadNextItems(),
        );
      },
      expect: () => [
        predicate<StoryWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<StoryWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.loadingStoryModelItems.length == KDimensions.loadItems &&
              state.itemsLoaded == KDimensions.loadItems,
        ),
        predicate<StoryWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.loadingStoryModelItems.length ==
                  KDimensions.loadItems * 2 &&
              state.itemsLoaded == KDimensions.loadItems * 2,
        ),
      ],
    );

    blocTest<StoryWatcherBloc, StoryWatcherState>(
      'emits [StoryWatcherState()]'
      ' when load StoryModel list, load all items it and update',
      build: () => storyWatcherBloc,
      act: (bloc) async {
        when(mockStoryRepository.getStoryItems()).thenAnswer(
          (_) => Stream.value(KTestText.storyModelItems),
        );
        bloc.add(const StoryWatcherEvent.started());
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<StoryWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loading,
            ),
            predicate<StoryWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loaded,
            ),
          ]),
          reason: 'Wait loading data',
        );
        for (var i = 1; i <= KTestText.storyModelItems.length; i++) {
          bloc.add(
            const StoryWatcherEvent.loadNextItems(),
          );
        }
        bloc.add(
          StoryWatcherEvent.updated([KTestText.storyModelItems.first]),
        );
      },
      expect: () => [
        predicate<StoryWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<StoryWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.loadingStoryModelItems.length == KDimensions.loadItems &&
              state.itemsLoaded == KDimensions.loadItems,
        ),
        for (var i = 1; i < KTestText.storyModelItems.length; i++)
          predicate<StoryWatcherState>(
            (state) =>
                state.loadingStatus == LoadingStatus.loaded &&
                state.loadingStoryModelItems.length ==
                    KDimensions.loadItems * i + 1 &&
                state.itemsLoaded == KDimensions.loadItems * i + 1,
          ),
        predicate<StoryWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.loadingStoryModelItems.length == 1 &&
              state.itemsLoaded == 1,
        ),
      ],
    );

    blocTest<StoryWatcherBloc, StoryWatcherState>(
      'emits [StoryWatcherState()]'
      ' when load StoryModel list and update',
      build: () => storyWatcherBloc,
      act: (bloc) async {
        when(mockStoryRepository.getStoryItems()).thenAnswer(
          (_) => Stream.value(KTestText.storyModelItems),
        );
        bloc.add(const StoryWatcherEvent.started());
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<StoryWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loading,
            ),
            predicate<StoryWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loaded,
            ),
          ]),
          reason: 'Wait loading data',
        );
        bloc.add(
          StoryWatcherEvent.updated(KTestText.storyModelItems.sublist(0, 2)),
        );
      },
      expect: () => [
        predicate<StoryWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<StoryWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.loadingStoryModelItems.length == KDimensions.loadItems &&
              state.itemsLoaded == KDimensions.loadItems,
        ),
        predicate<StoryWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.loadingStoryModelItems.length == KDimensions.loadItems &&
              state.itemsLoaded == KDimensions.loadItems,
        ),
      ],
    );
  });
}
