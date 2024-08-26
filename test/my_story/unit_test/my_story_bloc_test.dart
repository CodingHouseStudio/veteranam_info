import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.myStory} ${KGroupText.bloc}', () {
    late MyStoryWatcherBloc myStoryWatcherBloc;
    late IStoryRepository mockStoryRepository;
    late IAppAuthenticationRepository mockAuthRepository;

    setUp(() {
      mockStoryRepository = MockIStoryRepository();
      mockAuthRepository = MockIAppAuthenticationRepository();
      when(mockAuthRepository.currentUser)
          .thenAnswer((invocation) => KTestText.userWithoutPhoto);
      when(
        mockStoryRepository.getStoriesById(KTestText.userWithoutPhoto.id),
      ).thenAnswer((_) async => Right(KTestText.storyModelItems));
      myStoryWatcherBloc = MyStoryWatcherBloc(
        storyRepository: mockStoryRepository,
        appAuthenticationRepository: mockAuthRepository,
      );
    });
    blocTest<MyStoryWatcherBloc, MyStoryWatcherState>(
      'emits [MyStoryWatcherState] when data is successfully loaded',
      build: () => myStoryWatcherBloc,
      act: (bloc) async {
        bloc.add(const MyStoryWatcherEvent.started());
      },
      expect: () => [
        predicate<MyStoryWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<MyStoryWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loaded,
        ),
      ],
    );

    blocTest<MyStoryWatcherBloc, MyStoryWatcherState>(
      'emits [loading, error] when there is an error during data loading',
      build: () => myStoryWatcherBloc,
      act: (bloc) async {
        when(
          mockStoryRepository.getStoriesById(KTestText.userWithoutPhoto.id),
        ).thenAnswer((_) async => const Left(SomeFailure.serverError()));
        bloc.add(const MyStoryWatcherEvent.started());
      },
      expect: () => [
        predicate<MyStoryWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<MyStoryWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.error,
        ),
      ],
    );
  });
}
