import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

import '../text_dependency.dart';

void main() {
  group(KScreenBlocName.information, () {
    setUp(configureDependenciesTest);

    setUpAll(setUpGlobal);

    setupFirebaseAuthMocks();

    tearDown(GetIt.I.reset);
    testWidgets(KGroupText.intial, (tester) async {
      await tester.pumpApp(const InformationScreen());

      expect(
        find.byKey(KWidgetkeys.screen.information.screen),
        findsOneWidget,
      );

      await tester.pumpAndSettle();

      await newsCardHelper(tester: tester);
    });
    group(KGroupText.goRouter, () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets(KGroupText.intial, (tester) async {
        await tester.pumpApp(
          const InformationScreen(),
          mockGoRouter: mockGoRouter,
        );

        expect(
          find.byKey(KWidgetkeys.screen.information.screen),
          findsOneWidget,
        );

        await tester.pumpAndSettle();

        await newsCardHelper(tester: tester);
      });

      // group(KGroupText.goTo, () {
      // });
    });
  });
}
