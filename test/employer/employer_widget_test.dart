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
  group('${KScreenBlocName.employer} ', () {
    testWidgets('${KGroupText.intial} ', (tester) async {
      await tester.pumpApp(const EmployerScreen());

      expect(
        find.byKey(KWidgetkeys.screen.employer.screen),
        findsOneWidget,
      );

      await tester.pumpAndSettle();

      expect(
        find.byKey(KWidgetkeys.screen.employer.title),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employer.subtitle),
        findsOneWidget,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.employer.subtitle,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employer.mainInformation),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employer.textPosition),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employer.fieldPosition),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employer.textWage),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employer.fieldWage),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employer.textCity),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employer.fieldCity),
        findsOneWidget,
      );

      await dropListFieldBoxHelper(
        tester: tester,
        text: KMockText.dropDownList.first,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.employer.fieldCity,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employer.switchWidget),
        findsOneWidget,
      );

      await switchHelper(tester);

      expect(
        find.byKey(KWidgetkeys.screen.employer.textSwitchWidget),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employer.textContact),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employer.fieldContact),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employer.button),
        findsOneWidget,
      );
    });
    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.intial} ', (tester) async {
        await tester.pumpApp(
          const EmployerScreen(),
          mockGoRouter: mockGoRouter,
        );

        expect(
          find.byKey(KWidgetkeys.screen.employer.screen),
          findsOneWidget,
        );

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.screen.employer.title),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.employer.subtitle),
          findsOneWidget,
        );

        await scrollingHelper(
          tester: tester,
          itemKey: KWidgetkeys.screen.employer.subtitle,
        );

        expect(
          find.byKey(KWidgetkeys.screen.employer.mainInformation),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.employer.textPosition),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.employer.fieldPosition),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.employer.textWage),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.employer.fieldWage),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.employer.textCity),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.employer.fieldCity),
          findsOneWidget,
        );

        await dropListFieldBoxHelper(
          tester: tester,
          text: KMockText.dropDownList.first,
        );

        await scrollingHelper(
          tester: tester,
          itemKey: KWidgetkeys.screen.employer.fieldCity,
        );

        expect(
          find.byKey(KWidgetkeys.screen.employer.switchWidget),
          findsOneWidget,
        );

        await switchHelper(tester);

        expect(
          find.byKey(KWidgetkeys.screen.employer.textSwitchWidget),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.employer.textContact),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.employer.fieldContact),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.employer.button),
          findsOneWidget,
        );
      });
      // group('${KGroupText.goTo} ', () {
      // });
    });
  });
}
