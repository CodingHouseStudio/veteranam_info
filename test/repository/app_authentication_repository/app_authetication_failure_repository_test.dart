import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared.dart';

import '../../text_dependency.dart';

void main() {
  group(
      '${KScreenBlocName.appAuthentication} ${KGroupText.repository}'
      ' ${KGroupText.failure}', () {
    late AppAuthenticationRepository appAuthenticationRepository;
    late IStorage mockSecureStorageRepository;
    late firebase_auth.FirebaseAuth mockFirebaseAuth;
    late GoogleSignIn mockGoogleSignIn;
    late CacheClient mockCache;
    late firebase_auth.GoogleAuthProvider mockGoogleAuthProvider;
    late firebase_auth.UserCredential mockUserCredential;
    late FirestoreService mockFirestoreService;
    late GoogleSignInAccount mockGoogleSignInAccount;
    late firebase_auth.User mockUser;
    setUp(() {
      mockSecureStorageRepository = MockIStorage();
      mockFirebaseAuth = MockFirebaseAuth();
      mockGoogleSignIn = MockGoogleSignIn();
      mockCache = MockCacheClient();
      mockGoogleSignInAccount = MockGoogleSignInAccount();
      mockGoogleAuthProvider = MockGoogleAuthProvider();
      mockUserCredential = MockUserCredential();
      mockFirestoreService = MockFirestoreService();
      mockUser = MockUser();

      when(
        mockCache.read<User>(
          key: AppAuthenticationRepository.userCacheKey,
        ),
      ).thenAnswer(
        (_) => KTestText.user,
      );

      when(mockUserCredential.credential).thenAnswer(
        (_) => KTestText.authCredential,
      );
      when(mockFirebaseAuth.signInWithPopup(mockGoogleAuthProvider)).thenAnswer(
        (_) async => mockUserCredential,
      );
      when(
        mockFirebaseAuth.signInWithCredential(KTestText.authCredential),
      ).thenThrow(Exception(KGroupText.failure));
      when(
        mockFirebaseAuth.signInWithEmailAndPassword(
          email: KTestText.userEmailIncorrect,
          password: KTestText.passwordIncorrect,
        ),
      ).thenThrow(Exception(KGroupText.failure));
      when(
        mockFirebaseAuth.createUserWithEmailAndPassword(
          email: KTestText.userEmailIncorrect,
          password: KTestText.passwordIncorrect,
        ),
      ).thenThrow(Exception(KGroupText.failure));
      when(
        mockFirebaseAuth.sendPasswordResetEmail(
          email: KTestText.userEmailIncorrect,
        ),
      ).thenThrow(Exception(KGroupText.failure));
      when(
        mockFirebaseAuth.authStateChanges(),
      ).thenAnswer(
        (_) => Stream.error(KGroupText.failure),
      );
      when(
        mockCache.clear(),
      ).thenThrow(
        Exception(KGroupText.failure),
      );
      when(
        mockFirebaseAuth.signOut(),
      ).thenAnswer(
        (_) async {},
      );
      when(
        mockFirebaseAuth.signInAnonymously(),
      ).thenThrow(Exception(KGroupText.failure));
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
        mockFirestoreService.setUserSetting(
          userSetting: KTestText.userSetting,
          userId: KTestText.user.id,
        ),
      ).thenThrow(
        Exception(KGroupText.failure),
      );

      when(
        mockFirebaseAuth.currentUser,
      ).thenAnswer(
        (_) => mockUser,
      );
      when(
        mockUser.delete(),
      ).thenThrow(
        Exception(KGroupText.failure),
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
        isA<Left<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          const SomeFailure.serverError(),
        ),
      );
    });
    test('LogIn with email and password', () async {
      expect(
        await appAuthenticationRepository.logInWithEmailAndPassword(
          email: KTestText.userEmailIncorrect,
          password: KTestText.passwordIncorrect,
        ),
        isA<Left<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          const SomeFailure.serverError(),
        ),
      );
    });
    test('Sign up', () async {
      expect(
        await appAuthenticationRepository.signUp(
          email: KTestText.userEmailIncorrect,
          password: KTestText.passwordIncorrect,
        ),
        isA<Left<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          const SomeFailure.serverError(),
        ),
      );
    });
    test('Send verification code', () async {
      expect(
        await appAuthenticationRepository.sendVerificationCode(
          email: KTestText.userEmailIncorrect,
        ),
        isA<Left<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          const SomeFailure.serverError(),
        ),
      );
    });
    test('user', () async {
      expect(
        appAuthenticationRepository.user,
        emitsError(KGroupText.failure),
      );
      verifyNever(
        mockCache.write(
          key: AppAuthenticationRepository.userCacheKey,
          value: KTestText.user,
        ),
      );
    });
    test('Log Out', () async {
      final result = await appAuthenticationRepository.logOut();
      verify(
        mockCache.clear(),
      ).called(1);
      verifyNever(
        mockFirebaseAuth.signOut(),
      );
      verifyNever(
        mockGoogleSignIn.signOut(),
      );
      verifyNever(
        mockSecureStorageRepository.deleteAll(),
      );
      expect(
        result,
        isA<Left<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          const SomeFailure.serverError(),
        ),
      );
    });
    test('Log In Anonymously', () async {
      final result = await appAuthenticationRepository.logInAnonymously();
      verify(
        mockFirebaseAuth.signInAnonymously(),
      ).called(1);
      expect(
        result,
        isA<Left<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          const SomeFailure.serverError(),
        ),
      );
    });
    test('Delete user', () async {
      expect(
        await appAuthenticationRepository.deleteUser(),
        isA<Left<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          const SomeFailure.serverError(),
        ),
      );
    });
    test('Update User Setting', () async {
      expect(
        await appAuthenticationRepository.updateUserSetting(
          KTestText.userSetting,
        ),
        isA<Left<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          const SomeFailure.serverError(),
        ),
      );
    });
  });
}
