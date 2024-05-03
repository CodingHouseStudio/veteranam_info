import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../text_dependency.dart';

void main() {
  group('${KScreenBlocName.iAppAuthenticationRepository} ', () {
    group('${KGroupText.model} ', () {
      test('${KGroupText.shouldBe} ${KGroupText.modelJson}', () {
        final json = {
          'id': KTestText.user.id,
          'email': KTestText.user.email,
          'name': KTestText.user.name,
          'photo': KTestText.user.photo,
          'phoneNumber': KTestText.user.phoneNumber,
        };

        final user = User.fromJson(json);

        expect(user.id, KTestText.user.id);
        expect(user.email, KTestText.user.email);
        expect(user.name, KTestText.user.name);
        expect(user.phoneNumber, KTestText.user.phoneNumber);
        expect(user.photo, KTestText.user.photo);
      });
      test('${KGroupText.shouldBe} ${KGroupText.modelJson}', () {
        final json = {
          'id': KTestText.user.id,
        };

        final user = User.fromJson(json);

        expect(user.id, KTestText.user.id);
        expect(user.email, isNull);
        expect(user.name, isNull);
        expect(user.phoneNumber, isNull);
        expect(user.photo, isNull);
      });

      test('${KGroupText.shouldNotBe} ${KGroupText.modelJson}', () {
        final json = {
          'email': KTestText.user.email,
          'name': KTestText.user.name,
          'photo': KTestText.user.photo,
          'phoneNumber': KTestText.user.phoneNumber,
        };

        expect(
          () => QuestionModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group(' ${KGroupText.repository} ', () {
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
      late GoogleSignInAuthentication mockGoogleSignInAuthentication;
      group('${KGroupText.successful} ', () {
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
          when(mockFirebaseAuth.signInWithPopup(mockGoogleAuthProvider))
              .thenAnswer(
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
            (_) async => KTestText.userSetting,
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
            isA<Right<SomeFailure, bool>>()
                .having((e) => e.value, 'value', isTrue),
          );
        });
        test('LogIn with email and password', () async {
          expect(
            await appAuthenticationRepository.logInWithEmailAndPassword(
              email: KTestText.userEmail,
              password: KTestText.passwordCorrect,
            ),
            isA<Right<SomeFailure, bool>>()
                .having((e) => e.value, 'value', isTrue),
          );
        });
        test('Sign up', () async {
          expect(
            await appAuthenticationRepository.signUp(
              email: KTestText.userEmail,
              password: KTestText.passwordCorrect,
            ),
            isA<Right<SomeFailure, bool>>()
                .having((e) => e.value, 'value', isTrue),
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
            isA<Right<SomeFailure, bool>>()
                .having((e) => e.value, 'value', isTrue),
          );
        });
        test('Delete user', () async {
          expect(
            await appAuthenticationRepository.deleteUser(),
            isA<Right<SomeFailure, bool>>()
                .having((e) => e.value, 'value', isTrue),
          );
        });
        test('Get user setting', () async {
          expect(
            await appAuthenticationRepository.getUserSetting(),
            KTestText.userSetting,
          );
        });
        test('Get User', () async {
          expect(
            await appAuthenticationRepository.getUser(),
            KTestText.token,
          );
        });
        test('user', () async {
          final result = appAuthenticationRepository.user;
          await expectLater(
            result,
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
            isA<Right<SomeFailure, bool>>()
                .having((e) => e.value, 'value', isTrue),
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
            isA<Right<SomeFailure, bool>>()
                .having((e) => e.value, 'value', isTrue),
          );
        });
        test('Update user Setting(Set)', () async {
          final result = await appAuthenticationRepository.updateUserSetting(
            UserSetting.empty,
          );
          verifyNever(
            mockFirestoreService.updateUserSetting(UserSetting.empty),
          );
          verify(
            mockFirestoreService.setUserSetting(
              userSetting: UserSetting.empty,
              userId: KTestText.user.id,
            ),
          ).called(1);
          expect(
            result,
            isA<Right<SomeFailure, bool>>()
                .having((e) => e.value, 'value', isTrue),
          );
        });
      });
      group('${KGroupText.failure} ', () {
        setUp(() {
          mockSecureStorageRepository = MockIStorage();
          mockFirebaseAuth = MockFirebaseAuth();
          mockGoogleSignIn = MockGoogleSignIn();
          mockCache = MockCacheClient();
          mockGoogleAuthProvider = MockGoogleAuthProvider();
          mockUserCredential = MockUserCredential();
          mockFirestoreService = MockFirestoreService();

          when(mockUserCredential.credential).thenAnswer(
            (_) => KTestText.authCredential,
          );
          when(mockFirebaseAuth.signInWithPopup(mockGoogleAuthProvider))
              .thenAnswer(
            (_) async => mockUserCredential,
          );
          when(
            mockFirebaseAuth.signInWithCredential(KTestText.authCredential),
          ).thenThrow(Exception(KGroupText.failure));
          when(
            mockFirebaseAuth.signInWithEmailAndPassword(
              email: KTestText.useremailIncorrect,
              password: KTestText.passwordIncorrect,
            ),
          ).thenThrow(Exception(KGroupText.failure));
          when(
            mockFirebaseAuth.createUserWithEmailAndPassword(
              email: KTestText.useremailIncorrect,
              password: KTestText.passwordIncorrect,
            ),
          ).thenThrow(Exception(KGroupText.failure));
          when(
            mockFirebaseAuth.sendPasswordResetEmail(
              email: KTestText.useremailIncorrect,
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
            Exception(KGroupText.failure),
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
              email: KTestText.useremailIncorrect,
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
              email: KTestText.useremailIncorrect,
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
              email: KTestText.useremailIncorrect,
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
      group('${KGroupText.firebaseFailure} ', () {
        setUp(() {
          mockSecureStorageRepository = MockIStorage();
          mockFirebaseAuth = MockFirebaseAuth();
          mockGoogleSignIn = MockGoogleSignIn();
          mockCache = MockCacheClient();
          mockGoogleAuthProvider = MockGoogleAuthProvider();
          mockUserCredential = MockUserCredential();
          mockFirestoreService = MockFirestoreService();

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
              email: KTestText.useremailIncorrect,
              password: KTestText.passwordIncorrect,
            ),
          ).thenThrow(
            firebase_auth.FirebaseAuthException(
              code: KGroupText.firebaseFailure,
            ),
          );
          when(
            mockFirebaseAuth.createUserWithEmailAndPassword(
              email: KTestText.useremailIncorrect,
              password: KTestText.passwordIncorrect,
            ),
          ).thenThrow(
            firebase_auth.FirebaseAuthException(
              code: KGroupText.firebaseFailure,
            ),
          );
          when(
            mockFirebaseAuth.sendPasswordResetEmail(
              email: KTestText.useremailIncorrect,
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
              email: KTestText.useremailIncorrect,
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
              email: KTestText.useremailIncorrect,
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
              email: KTestText.useremailIncorrect,
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
      group('${KGroupText.failureGet} ', () {
        setUp(() {
          mockSecureStorageRepository = MockIStorage();
          mockFirebaseAuth = MockFirebaseAuth();
          mockGoogleSignIn = MockGoogleSignIn();
          mockCache = MockCacheClient();
          mockFirestoreService = MockFirestoreService();
          mockGoogleAuthProvider = MockGoogleAuthProvider();
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
        test('user', () async {
          final result = appAuthenticationRepository.user;
          await expectLater(
            result,
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
          expect(
            appAuthenticationRepository.user,
            emits(User.empty),
          );
        });
        test('Current user', () async {
          expect(
            appAuthenticationRepository.currentUser,
            User.empty,
          );
        });
        test('Is logged in', () async {
          expect(
            await appAuthenticationRepository.isLoggedIn(),
            isFalse,
          );
        });
      });
      group('${KGroupText.successful} isWeb false', () {
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
            ..isWeb = false
            ..googleAuthProvider = mockGoogleAuthProvider;
        });
        test('Sign up with google', () async {
          expect(
            await appAuthenticationRepository.signUpWithGoogle(),
            isA<Right<SomeFailure, bool>>()
                .having((e) => e.value, 'value', isTrue),
          );
        });
      });
    });
  });
}
