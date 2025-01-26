import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  setupFirebaseAuthMocks();

  tearDownAll(GetIt.I.reset);

  group('${KScreenBlocName.authentication} ${KGroupText.bloc} ', () {
    late AuthenticationRepository mockAuthenticationRepository;
    // late AuthenticationBloc authenticationBloc;
    setUp(() {
      mockAuthenticationRepository = MockAuthenticationRepository();
      // when(mockAuthenticationRepository.currentUser).thenAnswer(
      //   (realInvocation) => KTestVariables.user,
      // );
      // when(mockAuthenticationRepository.user).thenAnswer(
      //   (realInvocation) => Stream.value(KTestVariables.user),
      // );
      // when(mockAuthenticationRepository.currentUserSetting).thenAnswer(
      //   (realInvocation) => KTestVariables.userSetting,
      // );
      // when(
      //   mockAuthenticationRepository.updateUserSetting(
      //     userSetting: UserSetting.empty.copyWith(locale: Language.english),
      //   ),
      // ).thenAnswer(
      //   (realInvocation) async => const Right(true),
      // );
      when(
        mockAuthenticationRepository.logOut(),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );
      when(
        mockAuthenticationRepository.deleteUser(),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );
      when(mockAuthenticationRepository.currectAuthenticationStatus).thenAnswer(
        (realInvocation) => AuthenticationStatus.unknown,
      );
      // authenticationBloc = AuthenticationBloc(
      //   authenticationRepository: mockAuthenticationRepository,
      // );
    });
    group('Authentication Status Anonymous', () {
      setUp(() {
        when(mockAuthenticationRepository.status).thenAnswer(
          (realInvocation) => Stream.value(AuthenticationStatus.anonymous),
        );
      });
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [AuthenticationState.anonymous] when'
        ' AuthenticationInitialized',
        build: () => AuthenticationBloc(
          authenticationRepository: mockAuthenticationRepository,
        ),
        // act: (bloc) async {
        //   when(mockAuthenticationRepository.isAnonymously).thenAnswer(
        //     (realInvocation) => true,
        //   );
        //   bloc.add(
        //     AuthenticationInitialized(),
        //   );
        // },
        expect: () async => [
          const AuthenticationState.anonymous(),
        ],
      );
    });
    group('Authentication Status Authenticated', () {
      setUp(() {
        when(mockAuthenticationRepository.status).thenAnswer(
          (realInvocation) => Stream.value(AuthenticationStatus.authenticated),
        );
      });
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [AuthenticationState.Authenticated] when'
        ' AuthenticationInitialized',
        build: () => AuthenticationBloc(
          authenticationRepository: mockAuthenticationRepository,
        ),
        // act: (bloc) async {
        //   when(mockAuthenticationRepository.isAnonymously).thenAnswer(
        //     (realInvocation) => true,
        //   );
        //   bloc.add(
        //     AuthenticationInitialized(),
        //   );
        // },
        expect: () async => [
          const AuthenticationState.authenticated(),
        ],
      );
    });
    group('Authentication Status Unknown', () {
      setUp(() {
        when(mockAuthenticationRepository.status).thenAnswer(
          (realInvocation) => Stream.value(AuthenticationStatus.unknown),
        );
      });
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [AuthenticationState.unknown] when'
        ' AuthenticationInitialized',
        build: () => AuthenticationBloc(
          authenticationRepository: mockAuthenticationRepository,
        ),
        // act: (bloc) async {
        //   when(mockAuthenticationRepository.isAnonymously).thenAnswer(
        //     (realInvocation) => true,
        //   );
        //   bloc.add(
        //     AuthenticationInitialized(),
        //   );
        // },
        expect: () async => [
          const AuthenticationState.unknown(),
        ],
      );
    });
    group('Get Authentication Status Failure', () {
      setUp(() {
        when(mockAuthenticationRepository.status).thenAnswer(
          (realInvocation) => Stream.error(KGroupText.error),
        );
      });
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [AuthenticationState.failure] when'
        ' AuthenticationInitialized',
        build: () => AuthenticationBloc(
          authenticationRepository: mockAuthenticationRepository,
        ),
        // act: (bloc) async {
        //   when(mockAuthenticationRepository.isAnonymously).thenAnswer(
        //     (realInvocation) => true,
        //   );
        //   bloc.add(
        //     AuthenticationInitialized(),
        //   );
        // },
        expect: () async => [
          const AuthenticationState.failure(
            failure: SomeFailure.serverError,
            previousStatus: AuthenticationStatus.unknown,
          ),
        ],
      );
    });
    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationState] when'
      ' AuthenticationLogoutRequested',
      build: () => AuthenticationBloc(
        authenticationRepository: mockAuthenticationRepository,
      ),
      act: (bloc) async {
        bloc.add(
          AuthenticationLogoutRequested(),
        );
      },
      expect: () => <AuthenticationState>[
        // const AuthenticationState.authenticated(),
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationState] when'
      ' AuthenticationDeleteRequested',
      build: () => AuthenticationBloc(
        authenticationRepository: mockAuthenticationRepository,
      ),
      act: (bloc) async {
        bloc.add(
          AuthenticationDeleteRequested(),
        );
      },
      expect: () => <AuthenticationState>[
        // const AuthenticationState.authenticated(),
      ],
    );
    // blocTest<AuthenticationBloc, AuthenticationState>(
    //   'emits [AuthenticationState.unknown] when'
    //   ' AuthenticationStatusChanged',

    //   build: () => AuthenticationBloc(
    //     authenticationRepository: mockAuthenticationRepository,
    //   ),
    //   act: (bloc) async {
    //     when(mockAuthenticationRepository.user).thenAnswer(
    //       (realInvocation) => Stream.value(User.empty),
    //     );
    //     bloc.add(
    //       AuthenticationInitialized(),
    //     );
    //   },
    //   expect: () async => [
    //     const AuthenticationState.unknown(),
    //   ],
    // );
    // group('Call AuthenticationInitialized auto', () {
    //   setUp(() {
    //     when(mockAuthenticationRepository.currectAuthenticationStatus)
    //         .thenAnswer(
    //       (realInvocation) => AuthenticationStatus.authenticated,
    //     );
    //     when(mockAuthenticationRepository.status).thenAnswer(
    //       (realInvocation) => S
    // tream.value(AuthenticationStatus.authenticated),
    //     );
    //     // authenticationBloc.add(AuthenticationInitialized());
    //   });
    //   // blocTest<AuthenticationBloc, AuthenticationState>(
    //   //   'emits [AuthenticationState] when'
    //   //   ' AppLanguageChanged',
    //   //
    //   build: () => AuthenticationBloc(
    //     authenticationRepository: mockAuthenticationRepository,
    //   ),
    //   //   act: (bloc) async {
    //   //     bloc.add(
    //   //       const AppLanguageChanged(),
    //   //     );
    //   //   },
    //   //   expect: () async => [
    //   //     const AuthenticationState.authenticated(
    //   //       currentUser: KTestVariables.user,
    //   //       currentUserSetting: KTestVariables.userSetting,
    //   //     ),
    //   //     AuthenticationState.authenticated(
    //   //       currentUser: KTestVariables.user,
    //   //       currentUserSetting:
    //   //           KTestVariables.userSetting.copyWith(locale: Language.english),
    //   //     ),
    //   //   ],
    //   // );
    //   // blocTest<AuthenticationBloc, AuthenticationState>(
    //   //   'emits [AuthenticationState] when'
    //   //   ' AppUserRoleChanged',
    //   //
    //   build: () => AuthenticationBloc(
    //     authenticationRepository: mockAuthenticationRepository,
    //   ),
    //   //   act: (bloc) async {
    //   //     bloc.add(
    //   //       const AppUserRoleChanged(UserRole.veteran),
    //   //     );
    //   //   },
    //   //   expect: () => [
    //   //     const AuthenticationState.authenticated(
    //   //       currentUser: KTestVariables.user,
    //   //       currentUserSetting: KTestVariables.userSetting,
    //   //     ),
    //   //     AuthenticationState.authenticated(
    //   //       currentUser: KTestVariables.user,
    //   //       currentUserSetting:
    //   //           KTestVariables.userSetting.copyWith(userRole: UserRole.veteran),
    //   //     ),
    //   //   ],
    //   // );
    // });
  });
}
