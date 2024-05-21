import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../../text_dependency.dart';

void main() {
  group(
      '${KScreenBlocName.appAuthentication} ${KGroupText.repository}'
      ' ${KGroupText.successful}', () {
    late AppAuthenticationRepository appAuthenticationRepository;
    late IStorage mockSecureStorageRepository;
    late firebase_auth.FirebaseAuth mockFirebaseAuth;
    late GoogleSignIn mockGoogleSignIn;
    late CacheClient mockCache;
    late firebase_auth.GoogleAuthProvider mockGoogleAuthProvider;
    late firebase_auth.UserCredential mockUserCredential;
    late FirestoreService mockFirestoreService;
    late firebase_auth.User mockUser;
    late GoogleSignInAccount mockGoogleSignInAccount;
    setUp(() {
      mockSecureStorageRepository = MockIStorage();
      mockFirebaseAuth = MockFirebaseAuth();
      mockGoogleSignIn = MockGoogleSignIn();
      mockCache = MockCacheClient();
      mockGoogleAuthProvider = MockGoogleAuthProvider();
      mockUserCredential = MockUserCredential();
      mockFirestoreService = MockFirestoreService();
      mockUser = MockUser();
      mockGoogleSignInAccount = MockGoogleSignInAccount();

      when(mockUserCredential.credential).thenAnswer(
        (_) => KTestText.authCredential,
      );
      when(mockFirebaseAuth.signInWithPopup(mockGoogleAuthProvider)).thenAnswer(
        (_) async => mockUserCredential,
      );
      when(mockFirebaseAuth.signInWithCredential(KTestText.authCredential))
          .thenAnswer(
        (_) async => mockUserCredential,
      );
      when(
        mockFirebaseAuth.signInWithEmailAndPassword(
          email: KTestText.userEmail,
          password: KTestText.passwordCorrect,
        ),
      ).thenAnswer(
        (_) async => mockUserCredential,
      );
      when(
        mockFirebaseAuth.createUserWithEmailAndPassword(
          email: KTestText.userEmail,
          password: KTestText.passwordCorrect,
        ),
      ).thenAnswer(
        (_) async => mockUserCredential,
      );
      when(
        mockFirebaseAuth.sendPasswordResetEmail(
          email: KTestText.userEmail,
        ),
      ).thenAnswer(
        (_) async {},
      );
      when(
        mockSecureStorageRepository.readOne(
          keyItem: KAppText.usernameToken,
        ),
      ).thenAnswer(
        (_) async => KTestText.token,
      );
      when(mockUser.email).thenAnswer(
        (_) => KTestText.user.email,
      );
      when(mockUser.uid).thenAnswer(
        (_) => KTestText.user.id,
      );
      when(mockUser.displayName).thenAnswer(
        (_) => KTestText.user.name,
      );
      when(mockUser.photoURL).thenAnswer(
        (_) => KTestText.user.photo,
      );
      when(mockUser.phoneNumber).thenAnswer(
        (_) => KTestText.user.phoneNumber,
      );
      when(
        mockFirebaseAuth.authStateChanges(),
      ).thenAnswer(
        (_) => Stream.value(mockUser),
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
        (_) => KTestText.user,
      );
      when(
        mockCache.read<UserSetting>(
          key: AppAuthenticationRepository.userSettingCacheKey,
        ),
      ).thenAnswer(
        (_) => KTestText.userSetting,
      );
      when(
        mockCache.clear(),
      ).thenAnswer(
        (_) {},
      );
      when(
        mockFirebaseAuth.signOut(),
      ).thenAnswer(
        (_) async {},
      );
      when(
        mockGoogleSignIn.signOut(),
      ).thenAnswer(
        (_) async => mockGoogleSignInAccount,
      );
      when(
        mockSecureStorageRepository.deleteAll(),
      ).thenAnswer(
        (_) async {},
      );
      when(
        mockFirestoreService.getUserSetting(KTestText.user.id),
      ).thenAnswer(
        (_) => Stream.value(KTestText.userSetting),
      );
      when(
        mockFirestoreService.updateUserSetting(KTestText.userSetting),
      ).thenAnswer(
        (_) async {},
      );
      when(
        mockFirestoreService.setUserSetting(
          userSetting: UserSetting.empty,
          userId: KTestText.user.id,
        ),
      ).thenAnswer(
        (_) async {},
      );

      when(
        mockFirebaseAuth.currentUser,
      ).thenAnswer(
        (_) => mockUser,
      );
      when(
        mockUser.delete(),
      ).thenAnswer(
        (_) async {},
      );
      when(
        mockFirestoreService.deleteUserSetting(KTestText.user.id),
      ).thenAnswer(
        (_) async {},
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
      )
        ..isWeb = true
        ..googleAuthProvider = mockGoogleAuthProvider;
    });
    test('Sign up with google', () async {
      expect(
        await appAuthenticationRepository.signUpWithGoogle(),
        isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', isTrue),
      );
    });
    test('LogIn with email and password', () async {
      expect(
        await appAuthenticationRepository.logInWithEmailAndPassword(
          email: KTestText.userEmail,
          password: KTestText.passwordCorrect,
        ),
        isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', isTrue),
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
    test('Is logged in', () async {
      expect(
        await appAuthenticationRepository.isLoggedIn(),
        isTrue,
      );
    });
    test('Send verification code', () async {
      expect(
        await appAuthenticationRepository.sendVerificationCode(
          email: KTestText.userEmail,
        ),
        isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', isTrue),
      );
    });
    test('Delete user', () async {
      expect(
        await appAuthenticationRepository.deleteUser(),
        isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', isTrue),
      );
    });
    test('Current User Setting', () async {
      expect(
        appAuthenticationRepository.currentUserSetting,
        KTestText.userSetting,
      );
    });
    test('User Setting', () async {
      await expectLater(
        appAuthenticationRepository.userSetting,
        emitsInOrder([
          KTestText.userSetting,
        ]),
        reason: 'Wait for getting user setting',
      );
      verify(
        mockCache.write(
          key: AppAuthenticationRepository.userSettingCacheKey,
          value: KTestText.userSetting,
        ),
      ).called(1);
      expect(
        appAuthenticationRepository.userSetting,
        emits(KTestText.userSetting),
      );
    });
    test('Get User', () async {
      expect(
        await appAuthenticationRepository.getUser(),
        KTestText.token,
      );
    });
    test('user', () async {
      await expectLater(
        appAuthenticationRepository.user,
        emitsInOrder([
          KTestText.user,
        ]),
        reason: 'Wait for getting user',
      );
      verify(
        mockCache.write(
          key: AppAuthenticationRepository.userCacheKey,
          value: KTestText.user,
        ),
      ).called(1);
      expect(
        appAuthenticationRepository.user,
        emits(KTestText.user),
      );
    });
    test('Current User', () async {
      expect(
        appAuthenticationRepository.currentUser,
        KTestText.user,
      );
    });
    test('Log Out', () async {
      final result = await appAuthenticationRepository.logOut();
      verify(
        mockCache.clear(),
      ).called(1);
      verify(
        mockFirebaseAuth.signOut(),
      ).called(1);
      verify(
        mockGoogleSignIn.signOut(),
      ).called(1);
      verify(
        mockSecureStorageRepository.deleteAll(),
      ).called(1);
      expect(
        result,
        isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', isTrue),
      );
    });
    test('Update user Setting', () async {
      final result = await appAuthenticationRepository.updateUserSetting(
        KTestText.userSetting,
      );
      verify(
        mockFirestoreService.updateUserSetting(KTestText.userSetting),
      ).called(1);
      verifyNever(
        mockFirestoreService.setUserSetting(
          userSetting: KTestText.userSetting,
          userId: KTestText.user.id,
        ),
      );
      expect(
        result,
        isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', isTrue),
      );
    });
  });
}
