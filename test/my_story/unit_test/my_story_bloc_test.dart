import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
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
        mockStoryRepository.getStoriesByUserId(KTestText.userWithoutPhoto.id),
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
          mockStoryRepository.getStoriesByUserId(KTestText.userWithoutPhoto.id),
        ).thenAnswer(
          (_) async => Left(SomeFailure.serverError(error: null)),
        );
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
