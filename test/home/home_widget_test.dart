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
  group(KScreenBlocName.home, () {
    testWidgets(KGroupText.intial, (tester) async {
      await tester.pumpApp(const HomeScreen());

      expect(
        find.byKey(KWidgetkeys.screen.home.screen),
        findsOneWidget,
      );

      await tester.pumpAndSettle();

      expect(
        find.byKey(KWidgetkeys.screen.home.buttonMock),
        findsNothing,
      );

      expect(
        find.byKey(KWidgetkeys.screen.home.question),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.home.questionList),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.home.questionListTitle),
        findsOneWidget,
      );
      await questionHelper(tester);
    });
    group(KGroupText.goRouter, () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets(KGroupText.intial, (tester) async {
        await tester.pumpApp(const HomeScreen(), mockGoRouter: mockGoRouter);

        expect(
          find.byKey(KWidgetkeys.screen.home.screen),
          findsOneWidget,
        );

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.screen.home.buttonMock),
          findsNothing,
        );

        expect(
          find.byKey(KWidgetkeys.screen.home.question),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.home.questionList),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.home.questionListTitle),
          findsOneWidget,
        );
        await questionHelper(tester);
      });

      group(KGroupText.goTo, () {
        testWidgets('All footer widget navigation', (tester) async {
          await tester.pumpApp(const HomeScreen(), mockGoRouter: mockGoRouter);

          expect(
            find.byKey(KWidgetkeys.screen.home.screen),
            findsOneWidget,
          );

          await tester.pumpAndSettle();

          await footerButtonsHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });

        testWidgets('nawbar widget navigation', (tester) async {
          await tester.pumpApp(const HomeScreen(), mockGoRouter: mockGoRouter);

          expect(
            find.byKey(KWidgetkeys.screen.home.screen),
            findsOneWidget,
          );

          await tester.pumpAndSettle();

          await nawbarTitleHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
      });
    });
  });
}
