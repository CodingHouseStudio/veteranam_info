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
        find.byKey(KWidgetkeys.screenKeys.homeScreenKeys.screen),
        findsOneWidget,
      );

      await tester.pumpAndSettle();

      await filterBoxHelper(
        tester,
      );

      await messageFieldHelper(tester: tester, message: '');

      await dropListFieldBoxHelper(
        tester: tester,
        dropListitem: KMockText.dropDownList.elementAt(0),
      );

      await boxHelper(tester);

      await footerHelper(tester: tester, email: KTestText.useremail);
    });
    group('Mock Go Router', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('renders initial', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const HomeScreen(),
          ),
        );

        expect(
          find.byKey(KWidgetkeys.screenKeys.homeScreenKeys.screen),
          findsOneWidget,
        );

        await tester.pumpAndSettle();

        await filterBoxHelper(
          tester,
        );

        await messageFieldHelper(tester: tester, message: '');

        await dropListFieldBoxHelper(
          tester: tester,
          dropListitem: KMockText.dropDownList.elementAt(0),
        );

        await boxHelper(tester);

        await footerHelper(tester: tester, email: KTestText.useremail);
      });

      group('go to', () {
        testWidgets('All footer screens', (tester) async {
          await tester.pumpApp(
            MockGoRouterProvider(
              goRouter: mockGoRouter,
              child: const HomeScreen(),
            ),
          );

          expect(
            find.byKey(KWidgetkeys.screenKeys.homeScreenKeys.screen),
            findsOneWidget,
          );

          await tester.pumpAndSettle();

          await footerButtonsHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
      });
    });
  });
}
