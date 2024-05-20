import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../../text_dependency.dart';

void main() {
  group('${KScreenBlocName.appAuthentication} ${KGroupText.repository}', () {
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
    group('${KGroupText.firebaseFailure} ', () {
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

        when(mockUserCredential.credential).thenAnswer(
          (_) => KTestText.authCredential,
        );
        when(mockFirebaseAuth.signInWithPopup(mockGoogleAuthProvider))
            .thenAnswer(
          (_) async => mockUserCredential,
        );
        when(
          mockFirebaseAuth.signInWithCredential(KTestText.authCredential),
        ).thenThrow(
          firebase_auth.FirebaseAuthException(
            code: KGroupText.firebaseFailure,
          ),
        );
        when(
          mockFirebaseAuth.signInWithEmailAndPassword(
            email: KTestText.userEmailIncorrect,
            password: KTestText.passwordIncorrect,
          ),
        ).thenThrow(
          firebase_auth.FirebaseAuthException(
            code: KGroupText.firebaseFailure,
          ),
        );
        when(
          mockFirebaseAuth.createUserWithEmailAndPassword(
            email: KTestText.userEmailIncorrect,
            password: KTestText.passwordIncorrect,
          ),
        ).thenThrow(
          firebase_auth.FirebaseAuthException(
            code: KGroupText.firebaseFailure,
          ),
        );
        when(
          mockFirebaseAuth.sendPasswordResetEmail(
            email: KTestText.userEmailIncorrect,
          ),
        ).thenThrow(
          firebase_auth.FirebaseAuthException(
            code: KGroupText.firebaseFailure,
          ),
        );
        when(
          mockCache.clear(),
        ).thenThrow(
          firebase_auth.FirebaseAuthException(
            code: KGroupText.firebaseFailure,
          ),
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
          mockFirestoreService.updateUserSetting(KTestText.userSetting),
        ).thenThrow(
          firebase_auth.FirebaseAuthException(
            code: KGroupText.firebaseFailure,
          ),
        );

        when(
          mockFirebaseAuth.currentUser,
        ).thenAnswer(
          (_) => mockUser,
        );
        when(
          mockUser.delete(),
        ).thenThrow(
          firebase_auth.FirebaseAuthException(
            code: KGroupText.firebaseFailure,
          ),
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
            const SomeFailure.initial(),
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
            const SomeFailure.initial(),
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
            const SomeFailure.initial(),
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
            const SomeFailure.emailSendingFailed(),
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
            const SomeFailure.initial(),
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
  });
}
