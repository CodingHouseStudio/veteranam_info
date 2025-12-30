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

  group('${KScreenBlocName.user} ${KGroupText.repository} ', () {
    late UserRepository userRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    late ILanguageCacheRepository mockLanguageCacheRepository;
    late IDeviceRepository mockDeviceRepository;
    setUp(() {
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
      mockLanguageCacheRepository = MockILanguageCacheRepository();
      mockDeviceRepository = MockIDeviceRepository();
    });
    group('${KGroupText.successful} ', () {
      setUp(() {
        when(
          mockAppAuthenticationRepository.logInAnonymously(),
        ).thenAnswer(
          (_) async => const Right(KTestVariables.userAnonymous),
        );
        when(
          mockAppAuthenticationRepository.logInWithEmailAndPassword(
            email: KTestVariables.userEmail,
            password: KTestVariables.passwordCorrect,
          ),
        ).thenAnswer(
          (_) async => const Right(KTestVariables.user),
        );
        when(
          mockAppAuthenticationRepository.signUp(
            email: KTestVariables.userEmail,
            password: KTestVariables.passwordCorrect,
          ),
        ).thenAnswer(
          (_) async => const Right(KTestVariables.user),
        );
        when(mockAppAuthenticationRepository.signUpWithGoogle()).thenAnswer(
          (_) async => const Right(KTestVariables.user),
        );
        when(mockAppAuthenticationRepository.signUpWithFacebook()).thenAnswer(
          (_) async => const Right(KTestVariables.user),
        );
        when(mockAppAuthenticationRepository.currentUserSetting).thenAnswer(
          (_) => const UserSetting(id: KTestVariables.field),
        );
        when(mockAppAuthenticationRepository.currentUser).thenAnswer(
          (_) => User.empty,
        );
        when(mockAppAuthenticationRepository.user).thenAnswer(
          (_) => Stream.value(KTestVariables.user),
        );
        when(mockAppAuthenticationRepository.logOut()).thenAnswer(
          (_) async => const Right(true),
        );
        when(
          mockAppAuthenticationRepository.sendVerificationCode(
            email: KTestVariables.userEmail,
          ),
        ).thenAnswer(
          (_) async => const Right(true),
        );
        when(
          mockAppAuthenticationRepository.updateUserSetting(
            KTestVariables.userSetting,
          ),
        ).thenAnswer(
          (_) async => const Right(KTestVariables.repositoryUserSetting),
        );
        when(
          mockAppAuthenticationRepository.deleteUser(),
        ).thenAnswer(
          (_) async => const Right(true),
        );
        when(
          mockAppAuthenticationRepository.isAnonymously,
        ).thenAnswer(
          (_) => false,
        );
        // when(
        //   mockAppAuthenticationRepository
        //       .createFcmUserSettingAndRemoveDeletePameter(),
        // ).thenAnswer(
        //   (_) async => const Right(true),
        // );
        // when(mockAppAuthenticationRepository.currentUserSetting).thenAnswer(
        //   (_) => KTestVariables.userSettingModel,
        // );
        when(
          mockAppAuthenticationRepository.updateUserData(
            user: KTestVariables.profileUser,
            image: KTestVariables.filePickerItem,
          ),
        ).thenAnswer(
          (_) async => const Right(KTestVariables.profileUser),
        );
        when(
          mockAppAuthenticationRepository.updateUserData(
            user: KTestVariables.profileUser,
            image: null,
          ),
        ).thenAnswer(
          (_) async => const Right(KTestVariables.profileUser),
        );
        when(
          mockAppAuthenticationRepository.checkVerificationCode(
            KTestVariables.code,
          ),
        ).thenAnswer(
          (_) async => const Right(true),
        );
        when(
          mockAppAuthenticationRepository.resetPasswordUseCode(
            code: KTestVariables.code,
            newPassword: KTestVariables.passwordCorrect,
          ),
        ).thenAnswer(
          (_) async => const Right(true),
        );

        when(
          mockDeviceRepository.getDevice(),
        ).thenAnswer(
          (_) async => const Right(null),
        );

        userRepository = UserRepository(
          appAuthenticationRepository: mockAppAuthenticationRepository,
          languageCacheRepository: mockLanguageCacheRepository,
          deviceRepository: mockDeviceRepository,
        );
      });

      test('get user setting', () async {
        expect(
          userRepository.currentUserSetting,
          const UserSetting(id: KTestVariables.field),
        );
      });
      test('Update User Setting', () async {
        expect(
          await userRepository.updateUserSetting(
            userSetting: KTestVariables.userSetting,
          ),
          isA<Right<SomeFailure, bool>>()
              .having((e) => e.value, 'value', isTrue),
        );
      });
      test('Update user data', () async {
        when(
          mockAppAuthenticationRepository.updateUserSetting(
            KTestVariables.repositoryUserSetting,
          ),
        ).thenAnswer(
          (_) async => const Right(
            KTestVariables.repositoryUserSetting,
          ),
        );
        expect(
          await userRepository.updateUserData(
            user: KTestVariables.profileUser,
            image: KTestVariables.filePickerItem,
            nickname: KTestVariables.nicknameCorrect,
          ),
          isA<Right<SomeFailure, bool>>()
              .having((e) => e.value, 'value', isTrue),
        );
      });

      test('Update user data', () async {
        when(
          mockAppAuthenticationRepository.updateUserSetting(
            const UserSetting(
              id: KTestVariables.field,
              nickname: KTestVariables.nicknameCorrect,
            ),
          ),
        ).thenAnswer(
          (_) async => const Right(KTestVariables.repositoryUserSetting),
        );
        expect(
          await userRepository.updateUserData(
            user: KTestVariables.profileUser,
            image: null,
            nickname: KTestVariables.nicknameCorrect,
          ),
          isA<Right<SomeFailure, bool>>()
              .having((e) => e.value, 'value', isTrue),
        );
      });
      test('Update data unmodify data', () async {
        expect(
          await userRepository.updateUserData(
            user: User.empty,
            image: null,
            nickname: null,
          ),
          isA<Right<SomeFailure, bool>>().having(
            (e) => e.value,
            'value',
            isTrue,
          ),
        );
      });
      test('Update user settings', () async {
        when(mockAppAuthenticationRepository.currentUserSetting).thenAnswer(
          (_) => KTestVariables.userSettingModel,
        );

        expect(
          await userRepository.updateUserSetting(
            userSetting: KTestVariables.userSetting,
          ),
          isA<Right<SomeFailure, bool>>()
              .having((e) => e.value, 'value', isTrue),
        );
      });
      test('Is English', () async {
        expect(
          userRepository.isEnglish,
          isFalse,
        );
      });
    });
    group('${KGroupText.failure} ', () {
      setUp(() {
        when(
          mockAppAuthenticationRepository.logInAnonymously(),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );
        userRepository = UserRepository(
          appAuthenticationRepository: mockAppAuthenticationRepository,
          languageCacheRepository: mockLanguageCacheRepository,
          deviceRepository: mockDeviceRepository,
        );
        when(
          mockAppAuthenticationRepository.logInWithEmailAndPassword(
            email: KTestVariables.userEmail,
            password: KTestVariables.passwordCorrect,
          ),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );
        when(
          mockAppAuthenticationRepository.signUp(
            email: KTestVariables.userEmail,
            password: KTestVariables.passwordCorrect,
          ),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );
        when(mockAppAuthenticationRepository.signUpWithGoogle()).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );
        when(mockAppAuthenticationRepository.signUpWithFacebook()).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );
        when(mockAppAuthenticationRepository.logOut()).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );
        when(
          mockAppAuthenticationRepository.sendVerificationCode(
            email: KTestVariables.userEmailIncorrect,
          ),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );
        when(
          mockAppAuthenticationRepository.updateUserSetting(
            KTestVariables.userSettingModel,
          ),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );
        when(
          mockAppAuthenticationRepository.deleteUser(),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );
        when(mockAppAuthenticationRepository.currentUserSetting).thenAnswer(
          (_) => KTestVariables.userSettingModelIncorrect,
        );
        when(
          mockAppAuthenticationRepository.updateUserData(
            user: KTestVariables.profileUser,
            image: KTestVariables.filePickerItem,
          ),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );
        when(
          mockAppAuthenticationRepository.checkVerificationCode(
            KTestVariables.code,
          ),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );
        when(
          mockAppAuthenticationRepository.resetPasswordUseCode(
            code: KTestVariables.code,
            newPassword: KTestVariables.passwordCorrect,
          ),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );
      });
      test('Update User Setting', () async {
        expect(
          await userRepository.updateUserSetting(
            userSetting: KTestVariables.userSettingModel,
          ),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError,
          // ),
        );
      });
      test('Update user data', () async {
        when(
          mockAppAuthenticationRepository.updateUserSetting(
            const UserSetting(
              id: KTestVariables.field,
              nickname: KTestVariables.nicknameCorrect,
            ),
          ),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );
        expect(
          await userRepository.updateUserData(
            user: KTestVariables.profileUser,
            image: KTestVariables.filePickerItem,
            nickname: KTestVariables.nicknameCorrect,
          ),
          isA<Left<SomeFailure, bool>>(),
        );
      });
    });
  });
}
