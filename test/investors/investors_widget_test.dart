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
  group(KScreenBlocName.investors, () {
    testWidgets(KGroupText.intial, (tester) async {
      await tester.pumpApp(const InvestorsScreen());

      expect(
        find.byKey(KWidgetkeys.screen.investors.screen),
        findsOneWidget,
      );

      await tester.pumpAndSettle();

      await feedbackHelper(tester);

      // await feedbackEnterTextHelper(
      //   tester: tester,
      //   email: KTestText.useremailIncorrect,
      //   field: KTestText.field,
      //   isValid: false,
      // );

      // await feedbackEnterTextHelper(
      //   tester: tester,
      //   email: KTestText.useremail,
      //   field: KTestText.field,
      //   isValid: true,
      // );
    });
    group(KGroupText.goRouter, () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets(KGroupText.intial, (tester) async {
        await tester.pumpApp(
          const InvestorsScreen(),
          mockGoRouter: mockGoRouter,
        );

        expect(
          find.byKey(KWidgetkeys.screen.investors.screen),
          findsOneWidget,
        );

        await tester.pumpAndSettle();

        await feedbackHelper(tester);

        await feedbackEnterTextHelper(
          tester: tester,
          email: KTestText.useremailIncorrect,
          field: KTestText.field,
          isValid: false,
        );

        await feedbackEnterTextHelper(
          tester: tester,
          email: KTestText.useremail,
          field: KTestText.field,
          isValid: true,
        );
      });
      // group(KGroupText.goTo, () {
      // });
    });
  });
}
