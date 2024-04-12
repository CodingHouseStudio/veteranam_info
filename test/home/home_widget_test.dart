import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

import '../text_dependency.dart';
import 'home_widget/boxes_helper.dart';
import 'home_widget/home_widget.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group(KScreenBlocName.home, () {
    testWidgets(KGroupText.intial, (tester) async {
      await tester.pumpApp(const HomeScreen());

      expect(find.byKey(KWidgetkeys.screen.home.screen), findsOneWidget);

      await tester.pumpAndSettle();

      await homeBoxHelper(tester);

      await listQuestionHelper(tester);
    });

    testWidgets('Feedback enter correct text and save it', (tester) async {
      await tester.pumpApp(const HomeScreen());

      expect(find.byKey(KWidgetkeys.screen.home.screen), findsOneWidget);

      await tester.pumpAndSettle();

      await feedbackEnterTextHelper(
        tester: tester,
        email: KTestText.useremail,
        field: KTestText.field,
        isValid: true,
      );
    });

    testWidgets('Feedback enter incorrect text and save it', (tester) async {
      await tester.pumpApp(const HomeScreen());

      expect(find.byKey(KWidgetkeys.screen.home.screen), findsOneWidget);

      await tester.pumpAndSettle();

      await feedbackEnterTextHelper(
        tester: tester,
        email: KTestText.useremailIncorrect,
        field: KTestText.field,
        isValid: false,
      );
    });

    testWidgets('Feedback enter text and clear it', (tester) async {
      await tester.pumpApp(const HomeScreen());

      expect(find.byKey(KWidgetkeys.screen.home.screen), findsOneWidget);

      await tester.pumpAndSettle();

      await feedbackClearTextHelper(
        tester: tester,
        email: KTestText.useremail,
        field: KTestText.field,
      );
    });

    group(KGroupText.goRouter, () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets(KGroupText.intial, (tester) async {
        await tester.pumpApp(const HomeScreen(), mockGoRouter: mockGoRouter);

        expect(find.byKey(KWidgetkeys.screen.home.screen), findsOneWidget);

        await tester.pumpAndSettle();

        await listQuestionHelper(tester);
      });

      group(KGroupText.goTo, () {
        testWidgets('All footer widget navigation', (tester) async {
          await tester.pumpApp(const HomeScreen(), mockGoRouter: mockGoRouter);

          expect(find.byKey(KWidgetkeys.screen.home.screen), findsOneWidget);

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

        testWidgets('box widget navigation', (tester) async {
          await tester.pumpApp(const HomeScreen(), mockGoRouter: mockGoRouter);

          expect(find.byKey(KWidgetkeys.screen.home.screen), findsOneWidget);

          await tester.pumpAndSettle();

          await boxexHelper(
            tester: tester,
            routes: KTestText.boxRoutes,
            mockGoRouter: mockGoRouter,
          );
        });
      });
    });
  });
}
