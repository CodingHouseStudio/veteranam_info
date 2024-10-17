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
  group('${KScreenBlocName.privacyPolicy} ', () {
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    setUp(
      () {
        KTest.cashe = false;
        mockAppAuthenticationRepository = MockAppAuthenticationRepository();

        when(
          mockAppAuthenticationRepository.currentUserSetting,
        ).thenAnswer(
          (realInvocation) => KTestText.userSetting,
        );
      },
    );
    testWidgets('${KGroupText.initial} ', (tester) async {
      await markdownFileDialogPumpAppHelper(
        tester: tester,
        mockAppAuthenticationRepository: mockAppAuthenticationRepository,
      );

      await markdownFileDialogInitialHelper(tester);
    });

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.initial} ', (tester) async {
        await markdownFileDialogPumpAppHelper(
          tester: tester,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockGoRouter: mockGoRouter,
        );

        await markdownFileDialogInitialHelper(tester);
      });
      group('${KGroupText.goTo} ', () {
        testWidgets('${KRoute.home.name} ', (tester) async {
          await markdownFileDialogPumpAppHelper(
            tester: tester,
            mockAppAuthenticationRepository: mockAppAuthenticationRepository,
            mockGoRouter: mockGoRouter,
          );

          await cancelHelper(tester: tester, mockGoRouter: mockGoRouter);
        });
      });
    });
  });
}
