import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared.dart';

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
        (_) => KTestText.authCredential,
      );
      when(mockFirebaseAuth.signInWithPopup(mockGoogleAuthProvider)).thenAnswer(
        (_) async => mockUserCredential,
      );
      when(mockFirebaseAuth.signInWithPopup(mockFacebookAuthProvider))
          .thenAnswer(
        (_) async => mockUserCredential,
      );
      when(mockFirebaseAuth.signInWithCredential(KTestText.authCredential))
          .thenAnswer(
        (_) async => mockUserCredential,
      );
      when(mockUserCredential.user).thenAnswer(
        (_) => null,
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
        mockFirebaseAuth.signInAnonymously(),
      ).thenAnswer(
        (_) async => mockUserCredential,
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
        (_) => KTestText.userSettingModel,
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
        mockFirestoreService.getUserSetting(KTestText.user.id),
      ).thenAnswer(
        (_) => Stream.value(KTestText.userSettingModel),
      );
      // when(
      //   mockFirestoreService.updateUserSetting(KTestText.userSettingModel),
      // ).thenAnswer(
      //   (_) async {},
      // );
      when(
        mockFirestoreService.setUserSetting(
          userSetting: UserSetting.empty,
          userId: KTestText.user.id,
        ),
      ).thenAnswer(
        (_) async {},
      );

      when(
        mockDeviceRepository.getDevice(
          initialList: KTestText.userSettingModel.devicesInfo,
        ),
      ).thenAnswer(
        (_) async => Right(KTestText.deviceInfoModel),
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
        mockFirestoreService.deleteUserSetting(KTestText.user.id),
      ).thenAnswer(
        (_) async {},
      );

      when(
        mockUser.updateDisplayName(KTestText.profileUser.name),
      ).thenAnswer(
        (_) async {},
      );
      when(
        mockUser.updatePhotoURL(KTestText.imageModels.downloadURL),
      ).thenAnswer(
        (_) async {},
      );

      // when(
      //   mockFirebaseAuth.currentUser?.updateDisplayName(
      //     KTestText.profileUser.name,
      //   ),
      // ).thenAnswer(
      //   (_) async {},
      // );

      // when(
      //   mockUser.updatePhotoURL(KTestText.downloadURL),
      // ).thenAnswer(
      //   (_) async {},
      // );

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
          email: KTestText.userEmail,
          password: KTestText.passwordCorrect,
        ),
        isA<Right<SomeFailure, User?>>()
            .having((e) => e.value, 'value', isNull),
      );
    });
    test('Sign up', () async {
      expect(
        await appAuthenticationRepository.signUp(
          email: KTestText.userEmail,
          password: KTestText.passwordCorrect,
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
        KTestText.userSettingModel,
      );
    });
    test('User Setting', () async {
      await expectLater(
        appAuthenticationRepository.userSetting,
        emitsInOrder([
          KTestText.userSettingModel,
        ]),
        reason: 'Wait for getting user setting',
      );
      verify(
        mockCache.write(
          key: AppAuthenticationRepository.userSettingCacheKey,
          value: KTestText.userSettingModel,
        ),
      ).called(1);
      // expect(
      //   appAuthenticationRepository.userSetting,
      //   emits(KTestText.userSettingModel),
      // );
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
      // expect(
      //   appAuthenticationRepository.user,
      //   emits(KTestText.user),
      // );
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
        KTestText.userSettingModel,
      );
      // verifyNever(
      //   mockFirestoreService.setUserSetting(
      //     userSetting: KTestText.userSettingModel,
      //     userId: User.empty.id,
      //   ),
      // );
      verify(
        mockFirestoreService.setUserSetting(
          userSetting: KTestText.userSettingModel,
          userId: KTestText.user.id,
        ),
      ).called(1);
      expect(
        result,
        isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', isTrue),
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
    test('Create FCM Token for user setting', () async {
      final result = await appAuthenticationRepository.createFcmUserSetting();
      verify(
        mockDeviceRepository.getDevice(
          initialList: KTestText.userSettingModel.devicesInfo,
        ),
      ).called(1);
      expect(
        result,
        isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', isTrue),
      );
    });

    test('Update user data', () async {
      final result = await appAuthenticationRepository.updateUserData(
        user: KTestText.profileUser,
        image: KTestText.imageModels,
      );
      expect(
        result,
        isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', isTrue),
      );
    });
    //   // Перевірка, що методи були викликані з правильними аргументами
    //   verify(
    //     mockUser.updateDisplayName(KTestText.profileUser.name),
    //   ).called(1);

    //   verify(
    //     mockStorageService.saveImage(
    //       imageModel: KTestText.imageModel,
    //       id: KTestText.profileUser.id,
    //       collecltionName: FirebaseCollectionName.user,
    //     ),
    //   ).called(1);

    //   verify(
    //     mockUser.updatePhotoURL(KTestText.downloadURL),
    //   ).called(1);
    // });
  });
}
