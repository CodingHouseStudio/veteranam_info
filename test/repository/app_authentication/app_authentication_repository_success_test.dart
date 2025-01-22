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
      ' ${KGroupText.repository} ${KGroupText.successful}', () {
    late IAppAuthenticationRepository appAuthenticationRepository;
    late IStorage mockSecureStorageRepository;
    late firebase_auth.FirebaseAuth mockFirebaseAuth;
    late GoogleSignIn mockGoogleSignIn;
    late CacheClient mockCache;
    late firebase_auth.GoogleAuthProvider mockGoogleAuthProvider;
    late firebase_auth.UserCredential mockUserCredential;
    late FirestoreService mockFirestoreService;
    late firebase_auth.User mockUser;
    late IDeviceRepository mockDeviceRepository;
    late GoogleSignInAccount mockGoogleSignInAccount;
    late FacebookAuth mockFacebookAuth;
    late firebase_auth.FacebookAuthProvider mockFacebookAuthProvider;
    late StorageService mockStorageService;
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
      mockDeviceRepository = MockIDeviceRepository();
      mockFacebookAuth = MockFacebookAuth();
      mockFacebookAuthProvider = MockFacebookAuthProvider();
      mockStorageService = MockStorageService();

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
      when(mockFirebaseAuth.signInWithCredential(KTestVariables.authCredential))
          .thenAnswer(
        (_) async => mockUserCredential,
      );
      when(mockUserCredential.user).thenAnswer(
        (_) => null,
      );
      when(
        mockFirebaseAuth.signInWithEmailAndPassword(
          email: KTestVariables.userEmail,
          password: KTestVariables.passwordCorrect,
        ),
      ).thenAnswer(
        (_) async => mockUserCredential,
      );
      when(
        mockFirebaseAuth.createUserWithEmailAndPassword(
          email: KTestVariables.userEmail,
          password: KTestVariables.passwordCorrect,
        ),
      ).thenAnswer(
        (_) async => mockUserCredential,
      );
      when(
        mockFirebaseAuth.sendPasswordResetEmail(
          email: KTestVariables.userEmail,
          actionCodeSettings: firebase_auth.ActionCodeSettings(
            url: '/${KRoute.login.path}',
          ),
        ),
      ).thenAnswer(
        (_) async {},
      );
      when(
        mockFirebaseAuth.sendPasswordResetEmail(
          email: KTestVariables.userEmail,
        ),
      ).thenAnswer(
        (_) async {},
      );
      when(
        mockFirebaseAuth.signInAnonymously(),
      ).thenAnswer(
        (_) async => mockUserCredential,
      );
      when(
        mockSecureStorageRepository.readOne(
          keyItem: KAppText.usernameToken,
        ),
      ).thenAnswer(
        (_) async => KTestVariables.token,
      );
      when(mockUser.email).thenAnswer(
        (_) => KTestVariables.user.email,
      );
      when(mockUser.uid).thenAnswer(
        (_) => KTestVariables.user.id,
      );
      when(mockUser.displayName).thenAnswer(
        (_) => KTestVariables.user.name,
      );
      when(mockUser.photoURL).thenAnswer(
        (_) => KTestVariables.user.photo,
      );
      when(mockUser.phoneNumber).thenAnswer(
        (_) => KTestVariables.user.phoneNumber,
      );
      when(
        mockFirebaseAuth.authStateChanges(),
      ).thenAnswer(
        (_) => Stream.value(mockUser),
      );
      when(
        mockCache.write(
          key: AppAuthenticationRepository.userCacheKey,
          value: KTestVariables.user,
        ),
      ).thenAnswer(
        (_) {},
      );
      when(
        mockCache.read<User>(
          key: AppAuthenticationRepository.userCacheKey,
        ),
      ).thenAnswer(
        (_) => KTestVariables.user,
      );
      when(
        mockCache.read<UserSetting>(
          key: AppAuthenticationRepository.userSettingCacheKey,
        ),
      ).thenAnswer(
        (_) => KTestVariables.userSettingModel,
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
        mockFirestoreService.getUserSetting(KTestVariables.user.id),
      ).thenAnswer(
        (_) => Stream.value(KTestVariables.userSettingModel),
      );
      // when(
      //   mockFirestoreService.updateUserSetting(KTestVariables.userSettingModel),
      // ).thenAnswer(
      //   (_) async {},
      // );
      when(
        mockFirestoreService.setUserSetting(
          userSetting: UserSetting.empty,
          userId: KTestVariables.user.id,
        ),
      ).thenAnswer(
        (_) async {},
      );

      when(
        mockDeviceRepository.getDevice(
          initialList: KTestVariables.userSettingModel.devicesInfo,
        ),
      ).thenAnswer(
        (_) async => Right(KTestVariables.deviceInfoModel),
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
        mockUser.isAnonymous,
      ).thenAnswer(
        (_) => true,
      );
      when(
        mockFirestoreService.setUserSetting(
          userId: KTestVariables.userSetting.id,
          userSetting: KTestVariables.userSetting
              .copyWith(deletedOn: KTestVariables.dateTime),
        ),
      ).thenAnswer(
        (_) async {},
      );

      when(
        mockUser.updateDisplayName(KTestVariables.profileUser.name),
      ).thenAnswer(
        (_) async {},
      );
      when(
        mockUser.updatePhotoURL(KTestVariables.imageModels.downloadURL),
      ).thenAnswer(
        (_) async {},
      );

      when(
        mockFirebaseAuth.verifyPasswordResetCode(KTestVariables.code),
      ).thenAnswer(
        (_) async => KTestVariables.userEmail,
      );
      when(
        mockFirebaseAuth.confirmPasswordReset(
          code: KTestVariables.code,
          newPassword: KTestVariables.passwordCorrect,
        ),
      ).thenAnswer(
        (_) async {},
      );

      when(
        mockStorageService.saveFile(
          collecltionName: FirebaseCollectionName.user,
          filePickerItem: KTestVariables.filePickerItem,
          id: KTestVariables.profileUser.id,
        ),
      ).thenAnswer(
        (_) async => KTestVariables.profileUser.photo,
      );

      // when(
      //   mockFirebaseAuth.currentUser?.updateDisplayName(
      //     KTestVariables.profileUser.name,
      //   ),
      // ).thenAnswer(
      //   (_) async {},
      // );

      // when(
      //   mockUser.updatePhotoURL(KTestVariables.downloadURL),
      // ).thenAnswer(
      //   (_) async {},
      // );

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
        isA<Right<SomeFailure, User?>>()
            .having((e) => e.value, 'value', isNull),
      );
    });
    test('Sign up with google(credential null)', () async {
      when(mockUserCredential.credential).thenAnswer(
        (_) => null,
      );

      expect(
        await appAuthenticationRepository.signUpWithGoogle(),
        isA<Right<SomeFailure, User?>>()
            .having((e) => e.value, 'value', isNull),
      );
    });
    test('Sign up with facebook(credential null)', () async {
      when(mockUserCredential.credential).thenAnswer(
        (_) => null,
      );

      expect(
        await appAuthenticationRepository.signUpWithFacebook(),
        isA<Right<SomeFailure, User?>>()
            .having((e) => e.value, 'value', isNull),
      );
    });
    test('Sign up with facebook', () async {
      expect(
        await appAuthenticationRepository.signUpWithFacebook(),
        isA<Right<SomeFailure, User?>>()
            .having((e) => e.value, 'value', isNull),
      );
    });
    test('LogIn with email and password', () async {
      expect(
        await appAuthenticationRepository.logInWithEmailAndPassword(
          email: KTestVariables.userEmail,
          password: KTestVariables.passwordCorrect,
        ),
        isA<Right<SomeFailure, User?>>()
            .having((e) => e.value, 'value', isNull),
      );
    });
    test('Sign up', () async {
      expect(
        await appAuthenticationRepository.signUp(
          email: KTestVariables.userEmail,
          password: KTestVariables.passwordCorrect,
        ),
        isA<Right<SomeFailure, User?>>()
            .having((e) => e.value, 'value', isNull),
      );
    });
    test('Is logged in', () {
      expect(
        appAuthenticationRepository.isLoggedIn,
        isTrue,
      );
    });
    test('Send verification code', () async {
      UriExtension.testUrl = null;
      expect(
        await appAuthenticationRepository.sendVerificationCode(
          email: KTestVariables.userEmail,
        ),
        isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', isTrue),
      );
    });
    test('Send verification code(from not base url)', () async {
      UriExtension.testUrl = KTestVariables.fieldEmpty;
      expect(
        await appAuthenticationRepository.sendVerificationCode(
          email: KTestVariables.userEmail,
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
        KTestVariables.userSettingModel,
      );
    });
    test('User Setting', () async {
      await expectLater(
        appAuthenticationRepository.userSetting,
        emitsInOrder([
          KTestVariables.userSettingModel,
        ]),
        reason: 'Wait for getting user setting',
      );
      verify(
        mockCache.write(
          key: AppAuthenticationRepository.userSettingCacheKey,
          value: KTestVariables.userSettingModel,
        ),
      ).called(1);
      // expect(
      //   appAuthenticationRepository.userSetting,
      //   emits(KTestVariables.userSettingModel),
      // );
    });
    test('Get User', () async {
      expect(
        await appAuthenticationRepository.getUser(),
        KTestVariables.token,
      );
    });
    test('user', () async {
      await expectLater(
        appAuthenticationRepository.user,
        emitsInOrder([
          KTestVariables.user,
        ]),
        reason: 'Wait for getting user',
      );
      verify(
        mockCache.write(
          key: AppAuthenticationRepository.userCacheKey,
          value: KTestVariables.user,
        ),
      ).called(1);
      // expect(
      //   appAuthenticationRepository.user,
      //   emits(KTestVariables.user),
      // );
    });
    test('Current User', () async {
      expect(
        appAuthenticationRepository.currentUser,
        KTestVariables.user,
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
        KTestVariables.userSettingModel,
      );
      // verifyNever(
      //   mockFirestoreService.setUserSetting(
      //     userSetting: KTestVariables.userSettingModel,
      //     userId: User.empty.id,
      //   ),
      // );
      verify(
        mockFirestoreService.setUserSetting(
          userSetting: KTestVariables.userSettingModel,
          userId: KTestVariables.user.id,
        ),
      ).called(1);
      expect(
        result,
        isA<Right<SomeFailure, UserSetting>>()
            .having((e) => e.value, 'value', KTestVariables.userSettingModel),
      );
    });
    test('Log In Anonymously', () async {
      final result = await appAuthenticationRepository.logInAnonymously();
      verify(
        mockFirebaseAuth.signInAnonymously(),
      ).called(1);
      expect(
        result,
        isA<Right<SomeFailure, User?>>()
            .having((e) => e.value, 'value', isNull),
      );
    });
    test('Is Anonymously', () async {
      expect(
        appAuthenticationRepository.isAnonymously,
        true,
      );
    });
    test('Create FCM Token for user setting and user setting not changed',
        () async {
      final result = await appAuthenticationRepository
          .createFcmUserSettingAndRemoveDeletePameter();
      verify(
        mockDeviceRepository.getDevice(
          initialList: KTestVariables.userSettingModel.devicesInfo,
        ),
      ).called(1);
      expect(
        result,
        isA<Right<SomeFailure, bool>>()
            .having((e) => e.value, 'value', isFalse),
      );
    });
    test(
        'Create FCM Token for user setting and change user setting remove date',
        () async {
      when(
        mockCache.read<UserSetting>(
          key: AppAuthenticationRepository.userSettingCacheKey,
        ),
      ).thenAnswer(
        (_) => KTestVariables.userSettingModel
            .copyWith(deletedOn: KTestVariables.dateTime),
      );
      final result = await appAuthenticationRepository
          .createFcmUserSettingAndRemoveDeletePameter();
      verify(
        mockDeviceRepository.getDevice(
          initialList: KTestVariables.userSettingModel.devicesInfo,
        ),
      ).called(1);
      expect(
        result,
        isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', isTrue),
      );
    });

    test('Update user data', () async {
      final result = await appAuthenticationRepository.updateUserData(
        user: KTestVariables.profileUser,
        image: KTestVariables.filePickerItem,
      );
      expect(
        result,
        isA<Right<SomeFailure, User>>(),
        // .having((e) => e.value, 'value', KTestVariables.profileUser),
      );
    });

    test('Check verification code', () async {
      expect(
        await appAuthenticationRepository.checkVerificationCode(
          KTestVariables.code,
        ),
        isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', isTrue),
      );
    });
    test('Reset password use code', () async {
      expect(
        await appAuthenticationRepository.resetPasswordUseCode(
          code: KTestVariables.code,
          newPassword: KTestVariables.passwordCorrect,
        ),
        isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', isTrue),
      );
    });
  });
}
