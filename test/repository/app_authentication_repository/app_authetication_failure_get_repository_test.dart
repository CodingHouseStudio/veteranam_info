import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

void main() {
  tearDown(GetIt.I.reset);

  group(
      '${KScreenBlocName.appRepository} ${KScreenBlocName.authentication}'
      ' ${KGroupText.repository} ${KGroupText.failureGet}', () {
    late AppAuthenticationRepository appAuthenticationRepository;
    late IStorage mockSecureStorageRepository;
    late firebase_auth.FirebaseAuth mockFirebaseAuth;
    late GoogleSignIn mockGoogleSignIn;
    late CacheClient mockCache;
    late firebase_auth.GoogleAuthProvider mockGoogleAuthProvider;
    late FirestoreService mockFirestoreService;
    late FirebaseMessaging mockFirebaseMessaging;
    late firebase_auth.UserCredential mockUserCredential;
    setUp(() {
      mockSecureStorageRepository = MockIStorage();
      mockFirebaseAuth = MockFirebaseAuth();
      mockGoogleSignIn = MockGoogleSignIn();
      mockCache = MockCacheClient();
      mockFirestoreService = MockFirestoreService();
      mockGoogleAuthProvider = MockGoogleAuthProvider();
      mockUserCredential = MockUserCredential();
      mockFirebaseMessaging = MockFirebaseMessaging();
      when(
        mockFirebaseAuth.currentUser,
      ).thenAnswer(
        (_) => null,
      );
      when(
        mockFirebaseAuth.authStateChanges(),
      ).thenAnswer(
        (_) => Stream.value(null),
      );
      when(
        mockCache.write(
          key: AppAuthenticationRepository.userCacheKey,
          value: KTestText.user,
        ),
      ).thenAnswer(
        (_) {},
      );
      when(
        mockCache.read<User>(
          key: AppAuthenticationRepository.userCacheKey,
        ),
      ).thenAnswer(
        (_) => null,
      );
      when(
        mockFirestoreService.getUserSetting(KTestText.fieldEmpty),
      ).thenAnswer(
        (_) => Stream.value(UserSetting.empty),
      );
      when(
        mockFirebaseAuth.createUserWithEmailAndPassword(
          email: KTestText.userEmail,
          password: KTestText.passwordCorrect,
        ),
      ).thenAnswer(
        (_) async => mockUserCredential,
      );

      if (GetIt.I.isRegistered<FirestoreService>()) {
        GetIt.I.unregister<FirestoreService>();
      }
      GetIt.I.registerSingleton(mockFirestoreService);
      appAuthenticationRepository = AppAuthenticationRepository(
        mockSecureStorageRepository,
        mockFirebaseAuth,
        mockGoogleSignIn,
        mockCache,
        mockFirebaseMessaging,
      )
        ..isWeb = true
        ..googleAuthProvider = mockGoogleAuthProvider;
    });
    test('User Setting', () async {
      await expectLater(
        appAuthenticationRepository.userSetting,
        emitsInOrder([
          UserSetting.empty,
        ]),
        reason: 'Wait for getting user setting',
      );
      verifyNever(
        mockCache.write(
          key: AppAuthenticationRepository.userSettingCacheKey,
          value: KTestText.userSetting,
        ),
      );
      // expect(
      //   appAuthenticationRepository.userSetting,
      //   emits(UserSetting.empty),
      // );
    });
    test('user', () async {
      await expectLater(
        appAuthenticationRepository.user,
        emitsInOrder([
          User.empty,
        ]),
        reason: 'Wait for getting user',
      );
      verifyNever(
        mockCache.write(
          key: AppAuthenticationRepository.userCacheKey,
          value: KTestText.user,
        ),
      );
      // expect(
      //   appAuthenticationRepository.user,
      //   emits(User.empty),
      // );
    });
    test('Current user', () async {
      expect(
        appAuthenticationRepository.currentUser,
        User.empty,
      );
    });
    test('Is logged in', () async {
      expect(
        appAuthenticationRepository.isLoggedIn(),
        isFalse,
      );
    });
    test('Update user Setting(Set)', () async {
      final result = await appAuthenticationRepository.updateUserSetting(
        UserSetting.empty,
      );
      verifyNever(
        mockFirestoreService.setUserSetting(
          userSetting: UserSetting.empty,
          userId: User.empty.id,
        ),
      );
      verifyNever(
        mockFirestoreService.setUserSetting(
          userSetting: UserSetting.empty,
          userId: KTestText.user.id,
        ),
      );
      expect(
        result,
        isA<Right<SomeFailure, bool>>()
            .having((e) => e.value, 'value', isFalse),
      );
    });
    test('Is Anonymously', () async {
      expect(
        appAuthenticationRepository.isAnonymously(),
        false,
      );
    });
    test('Sign up', () async {
      expect(
        await appAuthenticationRepository.signUp(
          email: KTestText.userEmail,
          password: KTestText.passwordCorrect,
        ),
        isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', isTrue),
      );
    });
  });
}
