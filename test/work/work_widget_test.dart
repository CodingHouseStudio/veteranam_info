import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

import '../text_dependency.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group(KScreenBlocName.work, () {
    testWidgets(KGroupText.intial, (tester) async {
      await tester.pumpApp(const WorkScreen());

      expect(
        find.byKey(KWidgetkeys.screen.work.screen),
        findsOneWidget,
      );

      await tester.pumpAndSettle();

      await workCardHelper(tester);

      await footerHelper(tester: tester, email: KTestText.useremail);
    });
    group(KGroupText.goRouter, () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets(KGroupText.intial, (tester) async {
        await tester.pumpApp(const WorkScreen(), mockGoRouter: mockGoRouter);

        expect(
          find.byKey(KWidgetkeys.screen.work.screen),
          findsOneWidget,
        );

        await tester.pumpAndSettle();

        await workCardHelper(tester);
      });
      // group(KGroupText.goTo, () {
      // });
    });
  });
}
