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
  group(KScreenName.discounts, () {
    testWidgets('renders initial', (tester) async {
      await tester.pumpApp(const DiscountsScreen());

      expect(
        find.byKey(KWidgetkeys.screen.discounts.screen),
        findsOneWidget,
      );

      await tester.pumpAndSettle();
    });
    group('Mock Go Router', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('renders initial', (tester) async {
        await tester.pumpApp(
          const DiscountsScreen(),
          mockGoRouter: mockGoRouter,
        );

        expect(
          find.byKey(KWidgetkeys.screen.discounts.screen),
          findsOneWidget,
        );

        await tester.pumpAndSettle();
      });
      // group('go to', () {
      // });
    });
  });
}
