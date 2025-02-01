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
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  tearDownAll(GetIt.I.reset);

  group(
      '${KScreenBlocName.appRepository} ${KScreenBlocName.authentication}'
      ' ${KGroupText.repository} ${KGroupText.failure}', () {
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
      ExtendedDateTime.current = KTestVariables.dateTime;
      mockSecureStorageRepository = MockIStorage();
      mockFirebaseAuth = MockFirebaseAuth();
      mockGoogleSignIn = MockGoogleSignIn();
      mockCache = MockCacheClient();
      mockGoogleSignInAccount = MockGoogleSignInAccount();
      mockGoogleAuthProvider = MockGoogleAuthProvider();
      mockUserCredential = MockUserCredential();
      mockFirestoreService = MockFirestoreService();
      mockUser = MockUser();
      mockFacebookAuth = MockFacebookAuth();
      mockFacebookAuthProvider = MockFacebookAuthProvider();
      mockStorageService = MockStorageService();
      mockDeviceRepository = MockIDeviceRepository();

      when(
        mockCache.read<User>(
          key: AppAuthenticationRepository.userCacheKey,
        ),
      ).thenAnswer(
        (_) => KTestVariables.user,
      );

      when(mockUserCredential.credential).thenAnswer(
        (_) => KTestVariables.authCredential,
      );
      when(mockFirebaseAuth.signInWithPopup(mockGoogleAuthProvider)).thenAnswer(
        (_) async => mockUserCredential,
      );
      when(mockFirebaseAuth.signInWithPopup(mockFacebookAuthProvider))
          .thenAnswer(
        (_) async => mockUserCredential,
      );
      when(
        mockFirebaseAuth.signInWithCredential(KTestVariables.authCredential),
      ).thenThrow(Exception(KGroupText.failure));
      when(
        mockFirebaseAuth.signInWithEmailAndPassword(
          email: KTestVariables.userEmailIncorrect,
          password: KTestVariables.passwordIncorrect,
        ),
      ).thenThrow(Exception(KGroupText.failure));
      when(
        mockFirebaseAuth.createUserWithEmailAndPassword(
          email: KTestVariables.userEmailIncorrect,
          password: KTestVariables.passwordIncorrect,
        ),
      ).thenThrow(Exception(KGroupText.failure));
      when(
        mockFirebaseAuth.sendPasswordResetEmail(
          email: KTestVariables.userEmailIncorrect,
        ),
      ).thenThrow(Exception(KGroupText.failure));
      when(
        mockFirebaseAuth.userChanges(),
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
        mockFacebookAuth.logOut(),
      ).thenAnswer(
        (_) async {},
      );
      when(
        mockSecureStorageRepository.deleteAll(),
      ).thenAnswer(
        (_) async {},
      );
      when(
        mockFirestoreService.setUserSetting(
          userSetting: KTestVariables.userSetting,
          userId: KTestVariables.user.id,
        ),
      ).thenThrow(
        Exception(KGroupText.failure),
      );
      when(
        mockFirestoreService.setUserSetting(
          userSetting:
              UserSetting.empty.copyWith(deletedOn: KTestVariables.dateTime),
          userId: KTestVariables.user.id,
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
        mockFirestoreService.setUserSetting(
          userId: KTestVariables.userSetting.id,
          userSetting: KTestVariables.userSetting
              .copyWith(deletedOn: KTestVariables.dateTime),
        ),
      ).thenThrow(
        Exception(KGroupText.failure),
      );
      when(
        mockDeviceRepository.getDevice(
          initialList: KTestVariables.userSetting.devicesInfo,
        ),
      ).thenAnswer(
        (_) async => const Right(null),
      );
      when(
        mockDeviceRepository.getDevice(
          initialList: KTestVariables.userSetting.devicesInfo,
        ),
      ).thenAnswer(
        (_) async => const Left(SomeFailure.serverError),
      );

      when(
        mockFirebaseAuth.verifyPasswordResetCode(KTestVariables.code),
      ).thenThrow(
        Exception(KGroupText.failure),
      );
      when(
        mockFirebaseAuth.confirmPasswordReset(
          code: KTestVariables.code,
          newPassword: KTestVariables.passwordCorrect,
        ),
      ).thenThrow(
        Exception(KGroupText.failure),
      );
      when(
        mockStorageService.removeFile(
          KTestVariables.image,
        ),
      ).thenThrow(
        Exception(KGroupText.failure),
      );

      appAuthenticationRepository = AppAuthenticationRepository(
        cache: mockCache,
        deviceRepository: mockDeviceRepository,
        facebookAuthProvider: mockFacebookAuthProvider,
        facebookSignIn: mockFacebookAuth,
        firebaseAuth: mockFirebaseAuth,
        firestoreService: mockFirestoreService,
        googleAuthProvider: mockGoogleAuthProvider,
        googleSignIn: mockGoogleSignIn,
        secureStorageRepository: mockSecureStorageRepository,
        storageService: mockStorageService,
      );
      AppAuthenticationRepository.authCredential =
          KTestVariables.authCredential;
    });
    test('Sign up with google', () async {
      expect(
        await appAuthenticationRepository.signUpWithGoogle(),
        isA<Left<SomeFailure, User?>>(),
        // .having(
        //   (e) => e.value,
        //   'value',
        //   SomeFailure.serverError,
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
        //   SomeFailure.serverError,
        // ),
      );
    });
    test('LogIn with email and password', () async {
      expect(
        await appAuthenticationRepository.logInWithEmailAndPassword(
          email: KTestVariables.userEmailIncorrect,
          password: KTestVariables.passwordIncorrect,
        ),
        isA<Left<SomeFailure, User?>>(),
        // .having(
        //   (e) => e.value,
        //   'value',
        //   SomeFailure.serverError,
        // ),
      );
    });
    test('Sign up', () async {
      expect(
        await appAuthenticationRepository.signUp(
          email: KTestVariables.userEmailIncorrect,
          password: KTestVariables.passwordIncorrect,
        ),
        isA<Left<SomeFailure, User?>>(),
        // .having(
        //   (e) => e.value,
        //   'value',
        //   SomeFailure.serverError,
        // ),
      );
    });
    test('Send verification code', () async {
      expect(
        await appAuthenticationRepository.sendVerificationCode(
          email: KTestVariables.userEmailIncorrect,
        ),
        isA<Left<SomeFailure, bool>>(),
        // .having(
        //   (e) => e.value,
        //   'value',
        //   SomeFailure.serverError,
        // ),
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
          value: KTestVariables.user,
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
        result, isA<Left<SomeFailure, bool>>(),
        // .having(
        //   (e) => e.value,
        //   'value',
        //   SomeFailure.serverError,
        // ),
      );
    });
    test('Log In Anonymously', () async {
      final result = await appAuthenticationRepository.logInAnonymously();
      verify(
        mockFirebaseAuth.signInAnonymously(),
      ).called(1);
      expect(
        result, isA<Left<SomeFailure, User?>>(),
        // .having(
        //   (e) => e.value,
        //   'value',
        //   SomeFailure.serverError,
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
        //   SomeFailure.serverError,
        // ),
      );
    });
    test('Update User Setting', () async {
      expect(
        await appAuthenticationRepository.updateUserSetting(
          KTestVariables.userSetting,
        ),
        isA<Left<SomeFailure, UserSetting>>(),
        // .having(
        //   (e) => e.value,
        //   'value',
        //   SomeFailure.serverError,
        // ),
      );
    });
    test('Create FCM Token for user setting when get device error', () async {
      final result = await appAuthenticationRepository
          .createFcmUserSettingAndRemoveDeletePameter();
      verify(
        mockDeviceRepository.getDevice(
          initialList: KTestVariables.userSetting.devicesInfo,
        ),
      ).called(1);
      expect(
        result, isA<Left<SomeFailure, bool>>(),
        // .having(
        //   (e) => e.value,
        //   'value',
        //   SomeFailure.serverError,
        // ),
      );
    });
    test('Update user data', () async {
      when(
        mockUser.updateDisplayName(KTestVariables.profileUser.name),
      ).thenThrow(
        Exception(KGroupText.failure),
      );

      final result = await appAuthenticationRepository.updateUserData(
        user: KTestVariables.profileUser,
        image: KTestVariables.filePickerItem,
      );
      expect(
        result,
        isA<Left<SomeFailure, User>>(),
      );
    });

    test('Update user data(photo delete failure)', () async {
      when(
        mockStorageService.saveFile(
          collecltionName: FirebaseCollectionName.user,
          filePickerItem: KTestVariables.filePickerItem,
          id: KTestVariables.profileUser.id,
        ),
      ).thenAnswer(
        (_) async => KTestVariables.profileUser.photo,
      );
      when(
        mockUser.updateDisplayName(KTestVariables.profileUser.name),
      ).thenAnswer(
        (_) async {},
      );
      when(
        mockUser.updatePhotoURL(KTestVariables.imageModels.downloadURL),
      ).thenThrow(
        Exception(KGroupText.failure),
      );

      final result = await appAuthenticationRepository.updateUserData(
        user: KTestVariables.profileUser,
        image: KTestVariables.filePickerItem,
      );
      expect(
        result,
        isA<Left<SomeFailure, User>>(),
      );
    });

    test('Check verification code', () async {
      expect(
        await appAuthenticationRepository.checkVerificationCode(
          KTestVariables.code,
        ),
        isA<Left<SomeFailure, bool>>(),
      );
    });
    test('Reset password use code', () async {
      expect(
        await appAuthenticationRepository.resetPasswordUseCode(
          code: KTestVariables.code,
          newPassword: KTestVariables.passwordCorrect,
        ),
        isA<Left<SomeFailure, bool>>(),
      );
    });
  });
}
