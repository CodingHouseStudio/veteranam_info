import 'dart:async';

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

  group(
      '${KScreenBlocName.user} ${KGroupText.repository} '
      '${KGroupText.stream}', () {
    late UserRepository userRepository;
    late IAppAuthenticationRepository mockAppuserRepository;
    late StreamController<User> userStreamController;
    late ISharedPrefencesRepository mockSharedPrefencesRepository;

    setUp(() {
      userStreamController = StreamController<User>()..add(User.empty);
      mockAppuserRepository = MockIAppAuthenticationRepository();
      mockSharedPrefencesRepository = MockISharedPrefencesRepository();

      when(mockAppuserRepository.user).thenAnswer(
        (_) => userStreamController.stream,
      );

      when(mockAppuserRepository.currentUserSetting).thenAnswer(
        (_) => const UserSetting(id: KTestVariables.field),
      );

      when(mockAppuserRepository.userSetting).thenAnswer(
        (_) => Stream.value(const UserSetting(id: KTestVariables.field)),
      );

      when(
        mockAppuserRepository.logInAnonymously(),
      ).thenAnswer(
        (_) async => const Left(SomeFailure.serverError),
      );

      userRepository = UserRepository(
        appAuthenticationRepository: mockAppuserRepository,
        sharedPrefencesRepository: mockSharedPrefencesRepository,
      );
    });

    group('User stream when user changed(id)', () {
      late Timer timer;
      setUp(() {
        when(
          mockAppuserRepository.createFcmUserSettingAndRemoveDeletePameter(),
        ).thenAnswer(
          (_) async => const Right(true),
        );
        when(mockAppuserRepository.isAnonymously).thenAnswer(
          (_) => true,
        );

        timer = Timer(
          const Duration(milliseconds: 3),
          () async {
            // userSettingStreamController = StreamController<UserSetting>()
            //   ..add(const UserSetting(id: KTestVariables.field));
            userStreamController.add(KTestVariables.user);
            await Future.delayed(
              const Duration(milliseconds: 3),
              () => userStreamController
                  .add(KTestVariables.user.copyWith(id: '2')),
            );
          },
        );
      });

      test('user ${KGroupText.stream}', () async {
        await KTestConstants.delay;
        await expectLater(
          userRepository.user,
          emitsInOrder([
            KTestVariables.user,
            KTestVariables.user.copyWith(id: '2'),
          ]),
        );
      });
      tearDown(() => timer.cancel());
    });

    group('User Stream when createFcmUserSettingAndRemoveDeletePameter failure',
        () {
      late Timer timer;
      setUp(() {
        when(
          mockAppuserRepository.createFcmUserSettingAndRemoveDeletePameter(),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );
        when(mockAppuserRepository.isAnonymously).thenAnswer(
          (_) => true,
        );

        timer = Timer(
          const Duration(milliseconds: 3),
          () async {
            // userSettingStreamController = StreamController<UserSetting>()
            //   ..add(const UserSetting(id: KTestVariables.field));
            userStreamController.add(KTestVariables.user);
          },
        );
      });

      test('user ${KGroupText.stream}', () async {
        await expectLater(
          userRepository.user,
          emitsInOrder([
            KTestVariables.user,
          ]),
        );
      });
      tearDown(() => timer.cancel());
    });

    tearDown(() async {
      await userStreamController.close();
      userRepository.dispose();
    });
  });
}
