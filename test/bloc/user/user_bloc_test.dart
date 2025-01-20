import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);

  group('${KScreenBlocName.user} ${KGroupText.bloc} ', () {
    late UserRepository mockUserRepository;
    // late UserWatcherBloc UserWatcherBloc;
    setUp(() {
      mockUserRepository = MockUserRepository();
      when(mockUserRepository.currentUser).thenAnswer(
        (realInvocation) => User.empty,
      );
      when(mockUserRepository.currentUserSetting).thenAnswer(
        (realInvocation) => UserSetting.empty,
      );
    });

    group('${KGroupText.failure} ', () {
      setUp(() {
        when(mockUserRepository.user).thenAnswer(
          (realInvocation) {
            KTestConstants.delay;
            return Stream.error(KGroupText.failure);
          },
        );
        when(mockUserRepository.userSetting).thenAnswer(
          (realInvocation) => Stream.error(KGroupText.failure),
        );
        when(
          mockUserRepository.updateUserSetting(
            userSetting: UserSetting.empty.copyWith(
              locale: Language.english,
            ),
          ),
        ).thenAnswer(
          (realInvocation) async => const Left(SomeFailure.serverError),
        );
      });
      blocTest<UserWatcherBloc, UserWatcherState>(
        'emits [UserWatcherState] when'
        ' user and user setting init and language changed',
        build: () => UserWatcherBloc(
          userRepository: mockUserRepository,
        ),
        act: (bloc) async {
          await expectLater(
            bloc.stream,
            emitsInOrder([
              predicate<UserWatcherState>(
                (state) => state.failure != null,
              ),
            ]),
          );
          bloc.add(const LanguageChangedEvent());
        },
        expect: () => <UserWatcherState>[
          const UserWatcherState(
            user: User.empty,
            userSetting: UserSetting.empty,
            failure: SomeFailure.serverError,
          ),
          UserWatcherState(
            user: User.empty,
            userSetting: UserSetting.empty.copyWith(
              locale: Language.english,
            ),
            failure: SomeFailure.serverError,
          ),
        ],
      );
    });

    group('${KGroupText.successful} ', () {
      setUp(() {
        when(mockUserRepository.user).thenAnswer(
          (realInvocation) {
            KTestConstants.delay;
            return Stream.value(KTestVariables.user);
          },
        );
        when(mockUserRepository.userSetting).thenAnswer(
          (realInvocation) => Stream.value(KTestVariables.userSetting),
        );
        when(
          mockUserRepository.updateUserSetting(
            userSetting: KTestVariables.userSetting.copyWith(
              locale: Language.english,
            ),
          ),
        ).thenAnswer(
          (realInvocation) async => const Right(true),
        );
      });
      blocTest<UserWatcherBloc, UserWatcherState>(
        'emits [UserWatcherState] when'
        ' user and user setting init and language changed',
        build: () => UserWatcherBloc(
          userRepository: mockUserRepository,
        ),
        act: (bloc) async {
          await expectLater(
            bloc.stream,
            emitsInOrder([
              predicate<UserWatcherState>(
                (state) => state.userSetting.isNotEmpty,
              ),
              predicate<UserWatcherState>(
                (state) => state.user.isNotEmpty,
              ),
            ]),
            reason: 'Loading wait',
          );
          bloc.add(const LanguageChangedEvent());
        },
        expect: () => <UserWatcherState>[
          const UserWatcherState(
            user: User.empty,
            userSetting: KTestVariables.userSetting,
          ),
          const UserWatcherState(
            user: KTestVariables.user,
            userSetting: KTestVariables.userSetting,
          ),
          UserWatcherState(
            user: KTestVariables.user,
            userSetting: KTestVariables.userSetting.copyWith(
              locale: Language.english,
            ),
          ),
        ],
      );
    });
  });
}
