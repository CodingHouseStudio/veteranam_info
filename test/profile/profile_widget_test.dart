import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared.dart';

import '../test_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.profile} ', () {
    late AuthenticationRepository mockAuthenticationRepository;
    late IDataPickerRepository mockDataPickerRepository;
    late StreamController<User> profileStream;
    // late XFile image;
    setUp(() {
      mockAuthenticationRepository = MockAuthenticationRepository();
      mockDataPickerRepository = MockIDataPickerRepository();
      profileStream = StreamController()..add(KTestText.pureUser);
      // image = XFile(KTestText.imageModels.downloadURL);
      // mockAppAuthenticationRepository = MockAppAuthenticationRepository();

      when(mockAuthenticationRepository.currentUser).thenAnswer(
        (realInvocation) => KTestText.userWithoutPhoto,
      );
      when(mockAuthenticationRepository.currentUserSetting).thenAnswer(
        (realInvocation) => KTestText.userSettingModel,
      );
      when(
        mockAuthenticationRepository.updateUserData(
          nickname: KTestText.nicknameCorrect,
          image: KTestText.filePickerItem,
          user: KTestText.profileUserWithoutPhoto,
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
        (realInvocation) async => KTestText.filePickerItem,
      );

      when(mockAuthenticationRepository.isAnonymouslyOrEmty).thenAnswer(
        (realInvocation) => false,
      );
    });
    testWidgets('${KGroupText.initial} ', (tester) async {
      await profilePumpAppHelper(
        tester: tester,
        mockAuthenticationRepository: mockAuthenticationRepository,
        mockDataPickerRepository: mockDataPickerRepository,
      );

      await profileInitialHelper(tester);
    });
    // group('Nickname empty', () {
    //   setUp(() {
    //     when(mockAuthenticationRepository.currentUserSetting).thenAnswer(
    //       (realInvocation) => KTestText.userSetting,
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
        mockAuthenticationRepository: mockAuthenticationRepository,
        mockDataPickerRepository: mockDataPickerRepository,
      );

      await profileLogOutHelper(tester);
    });

    // testWidgets('Show delete account dialog', (tester) async {
    //   await profilePumpAppHelper(
    //     tester: tester,
    //     mockAuthenticationRepository: mockAuthenticationRepository,
    //     mockDataPickerRepository: mockDataPickerRepository,
    //   );

    //   await profileCardDeleteAccountHelper(tester);
    // });

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      // setUp(() => mockGoRouter = MockGoRouter());
      setUp(() {
        mockGoRouter = MockGoRouter();
        profileStream.add(KTestText.userWithoutPhoto);

        when(mockAuthenticationRepository.currentUser).thenAnswer(
          (realInvocation) => KTestText.userWithoutPhoto,
        );
      });
      testWidgets('${KGroupText.initial} ', (tester) async {
        await profilePumpAppHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          mockAuthenticationRepository: mockAuthenticationRepository,
          mockDataPickerRepository: mockDataPickerRepository,
        );

        await profileInitialHelper(tester);
      });

      testWidgets('Log out desk dialog unconfirm button pop', (tester) async {
        await profilePumpAppHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          mockAuthenticationRepository: mockAuthenticationRepository,
          mockDataPickerRepository: mockDataPickerRepository,
        );
        await logOutUnconfirmButtonlHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          icon: false,
          deskOpen: true,
        );
      });
      testWidgets('Log out mob dialog cancel icon pop', (tester) async {
        await profilePumpAppHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          mockAuthenticationRepository: mockAuthenticationRepository,
          mockDataPickerRepository: mockDataPickerRepository,
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
          mockAuthenticationRepository: mockAuthenticationRepository,
        );

        await logOutConfirmButtonlHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
        );
      });

      // testWidgets('Delete account desk dialog unconfirm button pop',
      //     (tester) async {
      //   await profilePumpAppHelper(
      //     tester: tester,
      //     mockGoRouter: mockGoRouter,
      //     mockAuthenticationRepository: mockAuthenticationRepository,
      //     mockDataPickerRepository: mockDataPickerRepository,
      //   );

      //   await deleteAccountUnconfirmButtonlHelper(
      //     tester: tester,
      //     mockGoRouter: mockGoRouter,
      //     icon: false,
      //     deskOpen: true,
      //   );
      // });

      // testWidgets('Delete account dialog cancel icon pop', (tester) async {
      //   await profilePumpAppHelper(
      //     tester: tester,
      //     mockGoRouter: mockGoRouter,
      //     mockAuthenticationRepository: mockAuthenticationRepository,
      //     mockDataPickerRepository: mockDataPickerRepository,
      //   );

      //   await deleteAccountUnconfirmButtonlHelper(
      //     tester: tester,
      //     mockGoRouter: mockGoRouter,
      //     icon: true,
      //   );
      // });

      // testWidgets('Delete account dialog confirm button pop',
      // (tester) async {
      //   await profilePumpAppHelper(
      //     tester: tester,
      //     mockGoRouter: mockGoRouter,
      //     mockAuthenticationRepository: mockAuthenticationRepository,
      //     mockDataPickerRepository: mockDataPickerRepository,
      //   );

      //   await deleteAccountConfirmButtonlHelper(
      //     tester: tester,
      //     mockGoRouter: mockGoRouter,
      //   );
      // });

      testWidgets('Send correct profile data', (tester) async {
        await profilePumpAppHelper(
          tester: tester,
          //mockGoRouter: mockGoRouter,
          mockAuthenticationRepository: mockAuthenticationRepository,
          mockDataPickerRepository: mockDataPickerRepository,
        );

        await profileFormsCorrectSaveHelper(
          tester: tester,
        );
      });

      testWidgets('Send incorrect profile data', (tester) async {
        await profilePumpAppHelper(
          tester: tester,
          //mockGoRouter: mockGoRouter,
          mockAuthenticationRepository: mockAuthenticationRepository,
          mockDataPickerRepository: mockDataPickerRepository,
        );

        await profileFormsIncorrectSaveHelper(
          tester: tester,
        );
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
  });
}
