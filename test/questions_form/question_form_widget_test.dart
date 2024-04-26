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
  group('${KScreenBlocName.questionsForm} ', () {
    testWidgets('${KGroupText.intial} ', (tester) async {
      await tester.pumpApp(const QuestionsFormScreen());

      expect(
        find.byKey(KWidgetkeys.screen.questionsForm.screen),
        findsOneWidget,
      );

      await tester.pumpAndSettle();

      expect(
        find.byKey(KWidgetkeys.screen.questionsForm.button),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.questionsForm.roleBusinessmen),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.questionsForm.roleBusinessmenText),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.questionsForm.roleCivilian),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.questionsForm.roleCivilianText),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.questionsForm.roleRelativeOfVeteran),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.questionsForm.roleRelativeOfVeteranText),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.questionsForm.roleTitle),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.questionsForm.roleVeteran),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.questionsForm.roleVeteranText),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.questionsForm.subtitle),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.questionsForm.title),
        findsOneWidget,
      );

      await chekPointHelper(tester);
    });
    testWidgets('checkPointSwitch', (tester) async {
      await tester.pumpApp(const QuestionsFormScreen());

      expect(
        find.byKey(KWidgetkeys.screen.questionsForm.screen),
        findsOneWidget,
      );

      await tester.pumpAndSettle();

      expect(
        find.byKey(KWidgetkeys.screen.questionsForm.roleVeteran),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.questionsForm.roleBusinessmen),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.questionsForm.roleCivilian),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.questionsForm.roleRelativeOfVeteran),
        findsOneWidget,
      );

      await tester.tap(
        find.byKey(KWidgetkeys.screen.questionsForm.roleCivilian),
      );

      await tester.pumpAndSettle();

      await tester.tap(
        find.byKey(KWidgetkeys.screen.questionsForm.roleBusinessmen),
      );

      await tester.pumpAndSettle();

      await tester.tap(
        find.byKey(KWidgetkeys.screen.questionsForm.roleRelativeOfVeteran),
      );

      await tester.pumpAndSettle();

      await tester.tap(
        find.byKey(KWidgetkeys.screen.questionsForm.roleVeteran),
      );

      await tester.pumpAndSettle();

      expect(find.byKey(KWidgetkeys.widget.checkPoint.icon), findsOneWidget);
    });
    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.intial} ', (tester) async {
        await tester.pumpApp(
          const QuestionsFormScreen(),
          mockGoRouter: mockGoRouter,
        );

        expect(
          find.byKey(KWidgetkeys.screen.questionsForm.screen),
          findsOneWidget,
        );

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.screen.questionsForm.button),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.questionsForm.roleBusinessmen),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.questionsForm.roleBusinessmenText),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.questionsForm.roleCivilian),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.questionsForm.roleCivilianText),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.questionsForm.roleRelativeOfVeteran),
          findsOneWidget,
        );

        expect(
          find.byKey(
            KWidgetkeys.screen.questionsForm.roleRelativeOfVeteranText,
          ),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.questionsForm.roleTitle),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.questionsForm.roleVeteran),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.questionsForm.roleVeteranText),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.questionsForm.subtitle),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.questionsForm.title),
          findsOneWidget,
        );

        await chekPointHelper(tester);
      });
      // group('${KGroupText.goTo} ', () {
      // });
    });
  });
}
