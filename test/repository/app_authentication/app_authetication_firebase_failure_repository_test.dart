import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  tearDown(GetIt.I.reset);

  group(
      '${KScreenBlocName.appRepository} ${KScreenBlocName.authentication}'
      ' ${KGroupText.repository} ${KGroupText.firebaseFailure} ', () {
    late IAppAuthenticationRepository appAuthenticationRepository;
    late IStorage mockSecureStorageRepository;
    late firebase_auth.FirebaseAuth mockFirebaseAuth;
    late GoogleSignIn mockGoogleSignIn;
    late CacheClient mockCache;
    late firebase_auth.GoogleAuthProvider mockGoogleAuthProvider;
    late firebase_auth.UserCredential mockUserCredential;
    late FirestoreService mockFirestoreService;
    late GoogleSignInAccount mockGoogleSignInAccount;
    late firebase_auth.FacebookAuthProvider mockFacebookAuthProvider;
    late StorageService mockStorageService;
    late IDeviceRepository mockDeviceRepository;
    late firebase_auth.User mockUser;
    late FacebookAuth mockFacebookAuth;
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
      mockDeviceRepository = MockIDeviceRepository();
      mockFacebookAuth = MockFacebookAuth();
      mockFacebookAuthProvider = MockFacebookAuthProvider();
      mockStorageService = MockStorageService();

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
      when(mockFirebaseAuth.signInWithPopup(mockFacebookAuthProvider))
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
        mockFirebaseAuth.signInAnonymously(),
      ).thenThrow(
        firebase_auth.FirebaseAuthException(
          code: KGroupText.firebaseFailure,
        ),
      );
      when(
        mockGoogleSignIn.signOut(),
      ).thenAnswer(
        (_) async => mockGoogleSignInAccount,
      );
      when(
        mockFacebookAuth.logOut(),
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
      when(
        mockFirestoreService.deleteUserSetting(KTestText.userSetting),
      ).thenAnswer(
        (_) async {},
      );

      when(
        mockUser.updateDisplayName(KTestText.profileUser.name),
      ).thenThrow(
        firebase_auth.FirebaseAuthException(
          code: KGroupText.firebaseFailure,
        ),
      );

      when(
        mockFirebaseAuth.verifyPasswordResetCode(KTestText.code),
      ).thenThrow(
        firebase_auth.FirebaseAuthException(
          code: KGroupText.firebaseFailure,
        ),
      );
      when(
        mockFirebaseAuth.confirmPasswordReset(
          code: KTestText.code,
          newPassword: KTestText.passwordCorrect,
        ),
      ).thenThrow(
        firebase_auth.FirebaseAuthException(
          code: KGroupText.firebaseFailure,
        ),
      );

      if (GetIt.I.isRegistered<FirestoreService>()) {
        GetIt.I.unregister<FirestoreService>();
      }
      GetIt.I.registerSingleton(mockFirestoreService);

      if (GetIt.I.isRegistered<StorageService>()) {
        GetIt.I.unregister<StorageService>();
      }
      GetIt.I.registerSingleton(mockStorageService);

      if (GetIt.I.isRegistered<IDeviceRepository>()) {
        GetIt.I.unregister<IDeviceRepository>();
      }
      GetIt.I.registerSingleton(mockDeviceRepository);
      appAuthenticationRepository = AppAuthenticationRepository(
        mockSecureStorageRepository,
        mockFirebaseAuth,
        mockGoogleSignIn,
        mockCache,
        mockFacebookAuth,
      )
        ..googleAuthProvider = mockGoogleAuthProvider
        ..facebookAuthProvider = mockFacebookAuthProvider;
    });
    test('Sign up with google', () async {
      expect(
        await appAuthenticationRepository.signUpWithGoogle(),
        isA<Left<SomeFailure, User?>>(),
        // .having(
        //   (e) => e.value,
        //   'value',

        //   SomeFailure.serverError(error: null),
        // ),
      );
    });
    test('Sign up with facebook', () async {
      expect(
        await appAuthenticationRepository.signUpWithFacebook(),
        isA<Left<SomeFailure, User?>>(),
        // .having(
        //   (e) => e.value,
        //   'value',

        //   SomeFailure.serverError(error: null),
        // ),
      );
    });
    test('LogIn with email and password', () async {
      expect(
        await appAuthenticationRepository.logInWithEmailAndPassword(
          email: KTestText.userEmailIncorrect,
          password: KTestText.passwordIncorrect,
        ),
        isA<Left<SomeFailure, User?>>(),
        // .having(
        //   (e) => e.value,
        //   'value',
        //   SomeFailure.serverError(error: null),
        // ),
      );
    });
    test('Sign up', () async {
      expect(
        await appAuthenticationRepository.signUp(
          email: KTestText.userEmailIncorrect,
          password: KTestText.passwordIncorrect,
        ),
        isA<Left<SomeFailure, User?>>(),
        // .having(
        //   (e) => e.value,
        //   'value',

        //   SomeFailure.serverError(error: null),
        // ),
      );
    });
    test('Send verification code', () async {
      expect(
        await appAuthenticationRepository.sendVerificationCode(
          email: KTestText.userEmailIncorrect,
        ),
        isA<Left<SomeFailure, bool>>(),
        // .having(
        //   (e) => e.value,
        //   'value',
        //   SomeFailure.emailSendingFailed(error: null),
        // ),
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
        isA<Left<SomeFailure, bool>>(),
        // .having(
        //   (e) => e.value,
        //   'value',

        //   SomeFailure.serverError(error: null),
        // ),
      );
    });
    test('Log In Anonymously', () async {
      final result = await appAuthenticationRepository.logInAnonymously();
      verify(
        mockFirebaseAuth.signInAnonymously(),
      ).called(1);
      expect(
        result,
        isA<Left<SomeFailure, User?>>(),
        // .having(
        //   (e) => e.value,
        //   'value',
        //   SomeFailure.serverError(error: null),
        // ),
      );
    });
    test('Delete user', () async {
      expect(
        await appAuthenticationRepository.deleteUser(),
        isA<Left<SomeFailure, bool>>(),
        // .having(
        //   (e) => e.value,
        //   'value',
        //   SomeFailure.serverError(error: null),
        // ),
      );
    });
    test('Update User Setting', () async {
      expect(
        await appAuthenticationRepository.updateUserSetting(
          KTestText.userSetting,
        ),
        isA<Left<SomeFailure, UserSetting>>(),
        // .having(
        //   (e) => e.value,
        //   'value',
        //   SomeFailure.serverError(error: null),
        // ),
      );
    });
    test('Update user data', () async {
      final result = await appAuthenticationRepository.updateUserData(
        user: KTestText.profileUser,
        image: KTestText.filePickerItem,
      );
      expect(
        result,
        isA<Left<SomeFailure, User>>(),
      );
    });

    test('Check verification code', () async {
      expect(
        await appAuthenticationRepository.checkVerificationCode(
          KTestText.code,
        ),
        isA<Left<SomeFailure, bool>>(),
      );
    });
    test('Reset password use code', () async {
      expect(
        await appAuthenticationRepository.resetPasswordUseCode(
          code: KTestText.code,
          newPassword: KTestText.passwordCorrect,
        ),
        isA<Left<SomeFailure, bool>>(),
      );
    });
  });
}
