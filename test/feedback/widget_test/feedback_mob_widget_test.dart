import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';
import '../helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.feedback} ', () {
    setUp(() {
      Config.testIsWeb = false;
      Config.falvourValue = Config.production;
      feedbackWidgetTestRegister();
    });

    testWidgets('${KGroupText.initial} ', (tester) async {
      await feedbackPumpAppHelper(
        tester,
      );

      await feedbackInitialHelper(tester);
    });

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.initial} ', (tester) async {
        when(mockUrlRepository.copy(KTestVariables.downloadURL)).thenAnswer(
          (invocation) async => const Right(true),
        );
        when(mockUrlRepository.copy(KAppText.email)).thenAnswer(
          (invocation) async => const Left(SomeFailure.copy),
        );
        await feedbackPumpAppHelper(
          tester,
          mockGoRouter: mockGoRouter,
        );

        await feedbackInitialHelper(tester);
      });
      group('${KGroupText.goTo} ', () {
        testWidgets('nawbar back button pop() navigation', (tester) async {
          await feedbackPumpAppHelper(
            tester,
            mockGoRouter: mockGoRouter,
          );
          // TODO(test): change
          // await nawbarBackButtonHelper(
          //   tester: tester,
          //   mockGoRouter: mockGoRouter,
          // );
        });
      });
    });
  });
}
