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
      when(mockStoryRepository.getStoryItems()).thenAnswer(
        (_) => Stream.value(KTestText.storyModelItems),
      );
      storyWatcherBloc = StoryWatcherBloc(
        storyRepository: mockStoryRepository,
      );
    });

    blocTest<StoryWatcherBloc, StoryWatcherState>(
      'emits [StoryWatcherState()]'
      ' when load StoryModel list',
      build: () => storyWatcherBloc,
      act: (bloc) async {
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
              state.loadingStatus == LoadingStatus.loading &&
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
      ' when load StoryModel list, load all items',
      build: () => storyWatcherBloc,
      act: (bloc) async {
        when(mockStoryRepository.getStoryItems()).thenAnswer(
          (_) => Stream.value([KTestText.storyModelItems.first]),
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
        // ..add(
        //   StoryWatcherEvent.updated([KTestText.storyModelItems.first]),
        // );
      },
      expect: () => [
        predicate<StoryWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<StoryWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loaded,
        ),
        // predicate<StoryWatcherState>(
        //   (state) =>
        //       state.loadingStatus == LoadingStatus.loaded &&
        //       state.loadingStoryModelItems.length != KDimensions.loadItems &&
        //       state.itemsLoaded != KDimensions.loadItems,
        // ),
      ],
    );

    blocTest<StoryWatcherBloc, StoryWatcherState>(
      'emits [StoryWatcherState()]'
      ' when load StoryModel list and update',
      build: () => storyWatcherBloc,
      act: (bloc) async {
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
          StoryWatcherEvent.updated(
            KTestText.storyModelItems.sublist(0, KDimensions.loadItems),
          ),
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
