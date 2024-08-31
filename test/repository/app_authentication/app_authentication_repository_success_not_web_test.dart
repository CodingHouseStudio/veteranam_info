import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
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
    late GoogleSignInAuthentication mockGoogleSignInAuthentication;

    late IDeviceRepository mockDeviceRepository;
    setUp(() {
      mockSecureStorageRepository = MockIStorage();
      mockFirebaseAuth = MockFirebaseAuth();
      mockGoogleSignIn = MockGoogleSignIn();
      mockCache = MockCacheClient();
      mockFirestoreService = MockFirestoreService();
      mockGoogleSignInAccount = MockGoogleSignInAccount();
      mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();
      mockGoogleAuthProvider = MockGoogleAuthProvider();
      mockUserCredential = MockUserCredential();

      mockDeviceRepository = MockIDeviceRepository();

      when(mockGoogleSignInAuthentication.idToken).thenAnswer(
        (_) => KTestText.token,
      );
      when(mockGoogleSignInAuthentication.accessToken).thenAnswer(
        (_) => KTestText.token,
      );
      when(mockGoogleSignInAccount.authentication).thenAnswer(
        (_) async => mockGoogleSignInAuthentication,
      );
      when(mockUserCredential.credential).thenAnswer(
        (_) => KTestText.authCredential,
      );
      when(mockGoogleSignIn.signIn()).thenAnswer(
        (_) async => mockGoogleSignInAccount,
      );
      when(mockFirebaseAuth.signInWithCredential(KTestText.oAuthCredential))
          .thenAnswer(
        (_) async => mockUserCredential,
      );
      when(
        mockFirestoreService.setUserSetting(
          userSetting: KTestText.userSetting,
          userId: KTestText.user.id,
        ),
      ).thenAnswer(
        (_) async {},
      );
      when(
        mockCache.read<User>(
          key: AppAuthenticationRepository.userCacheKey,
        ),
      ).thenAnswer(
        (_) => KTestText.user,
      );

      if (GetIt.I.isRegistered<FirestoreService>()) {
        GetIt.I.unregister<FirestoreService>();
      }
      GetIt.I.registerSingleton(mockFirestoreService);
      if (GetIt.I.isRegistered<IDeviceRepository>()) {
        GetIt.I.unregister<IDeviceRepository>();
      }
      GetIt.I.registerSingleton(mockDeviceRepository);
      appAuthenticationRepository = AppAuthenticationRepository(
        mockSecureStorageRepository,
        mockFirebaseAuth,
        mockGoogleSignIn,
        mockCache,
      )
        ..isWeb = false
        ..googleAuthProvider = mockGoogleAuthProvider;
    });
    test('Sign up with google', () async {
      expect(
        await appAuthenticationRepository.signUpWithGoogle(),
        isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', isTrue),
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
          userId: KTestText.user.id,
        ),
      ).called(1);
      expect(
        result,
        isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', isTrue),
      );
    });
  });
}
