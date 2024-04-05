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
  group(KScreenName.home, () {
    testWidgets('renders initial', (tester) async {
      await tester.pumpApp(const HomeScreen());

      expect(
        find.byKey(KWidgetkeys.screen.home.screen),
        findsOneWidget,
      );

      await tester.pumpAndSettle();

      await filterBoxHelper(
        tester,
      );

      await messageFieldHelper(tester: tester, message: KTestText.field);

      await dropListFieldBoxHelper(
        tester: tester,
        text: KMockText.dropDownList.elementAt(0),
      );

      await boxHelper(tester);
    });
    group('Mock Go Router', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('renders initial', (tester) async {
        await tester.pumpApp(const HomeScreen(), mockGoRouter: mockGoRouter);

        expect(
          find.byKey(KWidgetkeys.screen.home.screen),
          findsOneWidget,
        );

        await tester.pumpAndSettle();

        await filterBoxHelper(
          tester,
        );

        await messageFieldHelper(tester: tester, message: KTestText.field);

        await dropListFieldBoxHelper(
          tester: tester,
          text: KMockText.dropDownList.elementAt(0),
        );

        await boxHelper(tester);
      });

      group('go to', () {
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
