import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.profile} ', () {
    late UserRepository mockUserRepository;
    late IDataPickerRepository mockDataPickerRepository;
    late AuthenticationRepository mockAuthenticationRepository;
    late StreamController<User> profileStream;
    // late XFile image;
    setUp(() {
      mockUserRepository = MockUserRepository();
      mockDataPickerRepository = MockIDataPickerRepository();
      mockAuthenticationRepository = MockAuthenticationRepository();
      profileStream = StreamController()..add(KTestVariables.pureUser);
      // image = XFile(KTestVariables.imageModels.downloadURL);
      // mockAppAuthenticationRepository = MockAppAuthenticationRepository();

      when(mockUserRepository.currentUser).thenAnswer(
        (realInvocation) => KTestVariables.userWithoutPhoto,
      );
      when(mockUserRepository.currentUserSetting).thenAnswer(
        (realInvocation) => KTestVariables.userSettingModel,
      );
      when(mockUserRepository.user).thenAnswer(
        (realInvocation) => profileStream.stream,
      );
      when(
        mockUserRepository.updateUserData(
          nickname: KTestVariables.nicknameCorrect,
          image: KTestVariables.filePickerItem,
          user: KTestVariables.profileUserWithoutPhoto,
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );

      // when(imagePickerValue.pickImage(source: ImageSource.gallery)).
      // thenAnswer(
      //   (realInvocation) async => image,
      // );

      when(
        mockDataPickerRepository.getImage,
      ).thenAnswer(
        (realInvocation) async => KTestVariables.filePickerItem,
      );

      when(mockAuthenticationRepository.status).thenAnswer(
        (realInvocation) => Stream.value(AuthenticationStatus.authenticated),
      );
      when(mockAuthenticationRepository.currectAuthenticationStatus).thenAnswer(
        (realInvocation) => AuthenticationStatus.authenticated,
      );
      when(mockAuthenticationRepository.logOut()).thenAnswer(
        (realInvocation) async => const Right(true),
      );
      when(mockAuthenticationRepository.deleteUser()).thenAnswer(
        (realInvocation) async => const Right(true),
      );
    });
    testWidgets('${KGroupText.initial} ', (tester) async {
      await profilePumpAppHelper(
        tester: tester,
        mockUserRepository: mockUserRepository,
        mockDataPickerRepository: mockDataPickerRepository,
        mockAuthenticationRepository: mockAuthenticationRepository,
      );

      await profileInitialHelper(tester);
    });
    // group('Nickname empty', () {
    //   setUp(() {
    //     when(mockAuthenticationRepository.currentUserSetting).thenAnswer(
    //       (realInvocation) => KTestVariables.userSetting,
    //     );
    //   });
    //   testWidgets('${KGroupText.initial} ', (tester) async {
    //     await profilePumpAppHelper(
    //       tester: tester,
    //       mockAuthenticationRepository: mockAuthenticationRepository,
    //       mockDataPickerRepository: mockDataPickerRepository,
    //     );

    //     await profileInitialHelper(tester);
    //   });
    // });

    testWidgets('Show log out dialog', (tester) async {
      await profilePumpAppHelper(
        tester: tester,
        mockUserRepository: mockUserRepository,
        mockDataPickerRepository: mockDataPickerRepository,
        mockAuthenticationRepository: mockAuthenticationRepository,
      );

      await profileLogOutHelper(tester);
    });

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.initial} ', (tester) async {
        await profilePumpAppHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          mockUserRepository: mockUserRepository,
          mockDataPickerRepository: mockDataPickerRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
        );

        await profileInitialHelper(tester);
      });

      testWidgets('Log out desk dialog unconfirm button pop', (tester) async {
        await profilePumpAppHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          mockUserRepository: mockUserRepository,
          mockDataPickerRepository: mockDataPickerRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
        );
        await logOutUnconfirmButtonlHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          icon: false,
          // deskOpen: true,
        );
      });
      testWidgets('Log out mob dialog cancel icon pop', (tester) async {
        await profilePumpAppHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          mockUserRepository: mockUserRepository,
          mockDataPickerRepository: mockDataPickerRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
        );

        await logOutUnconfirmButtonlHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          icon: true,
        );
      });

      testWidgets('Log out dialog confirm button pop', (tester) async {
        await profilePumpAppHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          mockDataPickerRepository: mockDataPickerRepository,
          mockUserRepository: mockUserRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
        );

        await logOutConfirmButtonlHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
        );
      });

      testWidgets('Delete account desk dialog unconfirm button pop',
          (tester) async {
        await profilePumpAppHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          mockUserRepository: mockUserRepository,
          mockDataPickerRepository: mockDataPickerRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
        );

        await deleteAccountUnconfirmButtonlHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          icon: false,
          deskOpen: true,
        );
      });

      testWidgets('Delete account dialog cancel icon pop', (tester) async {
        await profilePumpAppHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          mockUserRepository: mockUserRepository,
          mockDataPickerRepository: mockDataPickerRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
        );

        await deleteAccountUnconfirmButtonlHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          icon: true,
        );
      });

      testWidgets('Delete account dialog confirm button pop', (tester) async {
        await profilePumpAppHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          mockUserRepository: mockUserRepository,
          mockDataPickerRepository: mockDataPickerRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
        );

        await deleteAccountConfirmButtonlHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
        );
      });

      testWidgets('Send correct profile data', (tester) async {
        await profilePumpAppHelper(
          tester: tester,
          //mockGoRouter: mockGoRouter,
          mockUserRepository: mockUserRepository,
          mockDataPickerRepository: mockDataPickerRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
        );

        await profileFormsCorrectSaveHelper(
          tester: tester,
        );
      });

      group('Current user empty ', () {
        setUp(
          () => when(mockUserRepository.currentUser).thenAnswer(
            (realInvocation) => KTestVariables.pureUser,
          ),
        );
        testWidgets('Send incorrect profile data', (tester) async {
          await profilePumpAppHelper(
            tester: tester,
            //mockGoRouter: mockGoRouter,
            mockUserRepository: mockUserRepository,
            mockDataPickerRepository: mockDataPickerRepository,
            mockAuthenticationRepository: mockAuthenticationRepository,
          );
          profileStream.add(
            KTestVariables.profileUserWithoutPhoto.copyWith(
              id: 'none',
              email: KTestVariables.userEmail,
              name: null,
            ),
          );

          await profileFormsIncorrectSaveHelper(
            tester: tester,
          );
        });
      });

      // group('${KGroupText.goTo} ', () {
      //   testWidgets('Profile Navigation', (tester) async {
      //     await profilePumpAppHelper(
      //       tester: tester,
      //       mockGoRouter: mockGoRouter,
      //       mockAuthenticationRepository: mockAuthenticationRepository,
      //     );

      //     await profileNavigationHelper(
      //       tester: tester,
      //       mockGoRouter: mockGoRouter,
      //     );
      //   });
      // });

      // group('${Config.business} ', () {
      //     setUp(
      //       () => Config.roleValue = Config.business,
      //     );

      //     testWidgets('${KRoute.myDiscounts.name} ', (tester) async {
      //       await profilePumpAppHelper(
      //         tester: tester,
      //         mockGoRouter: mockGoRouter,
      //         mockAuthenticationRepository: mockAuthenticationRepository,
      //       );

      //       await profileMyDiscountsHelper(
      //         tester: tester,
      //         mockGoRouter: mockGoRouter,
      //       );
      //     });
      //   });
    });
    tearDown(() async => profileStream.close());
  });
}
