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
      ' ${KGroupText.repository} ${KGroupText.successful} isWeb false', () {
    late IAppAuthenticationRepository appAuthenticationRepository;
    late IStorage mockSecureStorageRepository;
    late firebase_auth.FirebaseAuth mockFirebaseAuth;
    late GoogleSignIn mockGoogleSignIn;
    late CacheClient mockCache;
    late firebase_auth.GoogleAuthProvider mockGoogleAuthProvider;
    late firebase_auth.UserCredential mockUserCredential;
    late FirestoreService mockFirestoreService;
    late GoogleSignInAccount mockGoogleSignInAccount;
    late FacebookAuth mockFacebookAuth;
    late GoogleSignInAuthentication mockGoogleSignInAuthentication;
    late LoginResult mockLoginResult;
    late firebase_auth.FacebookAuthProvider mockFacebookAuthProvider;
    late StorageService mockStorageService;
    late IDeviceRepository mockDeviceRepository;
    setUp(() {
      Config.testIsWeb = false;
      mockSecureStorageRepository = MockIStorage();
      mockFirebaseAuth = MockFirebaseAuth();
      mockGoogleSignIn = MockGoogleSignIn();
      mockCache = MockCacheClient();
      mockFirestoreService = MockFirestoreService();
      mockGoogleSignInAccount = MockGoogleSignInAccount();
      mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();
      mockGoogleAuthProvider = MockGoogleAuthProvider();
      mockUserCredential = MockUserCredential();
      mockFacebookAuth = MockFacebookAuth();
      mockLoginResult = MockLoginResult();
      mockFacebookAuthProvider = MockFacebookAuthProvider();
      mockStorageService = MockStorageService();
      mockDeviceRepository = MockIDeviceRepository();

      when(mockGoogleSignInAuthentication.idToken).thenAnswer(
        (_) => KTestVariables.token,
      );
      when(mockGoogleSignInAuthentication.accessToken).thenAnswer(
        (_) => KTestVariables.token,
      );
      when(mockGoogleSignInAccount.authentication).thenAnswer(
        (_) async => mockGoogleSignInAuthentication,
      );
      when(mockUserCredential.credential).thenAnswer(
        (_) => KTestVariables.authCredential,
      );

      when(mockUserCredential.user).thenAnswer(
        (_) => null,
      );
      when(mockGoogleSignIn.signIn()).thenAnswer(
        (_) async => mockGoogleSignInAccount,
      );
      when(mockFacebookAuth.login()).thenAnswer(
        (_) async => mockLoginResult,
      );
      when(mockFirebaseAuth.signInWithCredential(KTestVariables.authCredential))
          .thenAnswer(
        (_) async => mockUserCredential,
      );
      when(mockUserCredential.user).thenAnswer(
        (_) => null,
      );
      when(
        mockFirestoreService.setUserSetting(
          userSetting: KTestVariables.userSetting,
          userId: KTestVariables.user.id,
        ),
      ).thenAnswer(
        (_) async {},
      );
      when(
        mockCache.read<User>(
          key: AppAuthenticationRepository.userCacheKey,
        ),
      ).thenAnswer(
        (_) => KTestVariables.user,
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
        isA<Right<SomeFailure, User?>>()
            .having((e) => e.value, 'value', isNull),
      );
    });

    test('Sign up with facebook', () async {
      when(mockLoginResult.accessToken).thenAnswer(
        (_) => LimitedToken(
          userId: KTestVariables.user.id,
          userName: KTestVariables.user.name!,
          userEmail: KTestVariables.user.email,
          nonce: KTestVariables.field,
          tokenString: KTestVariables.token,
        ),
      );
      expect(
        await appAuthenticationRepository.signUpWithFacebook(),
        isA<Right<SomeFailure, User?>>()
            .having((e) => e.value, 'value', isNull),
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
      verify(
        mockFirestoreService.setUserSetting(
          userSetting: UserSetting.empty,
          userId: KTestVariables.user.id,
        ),
      ).called(1);
      expect(
        result,
        isA<Right<SomeFailure, UserSetting>>()
            .having((e) => e.value, 'value', UserSetting.empty),
      );
    });
  });
}
