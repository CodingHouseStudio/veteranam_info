import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

import '../text_dependency.dart';

void main() {
  group(KScreenName.information, () {
    setUp(configureDependenciesTest);

    setUpAll(setUpGlobal);

    setupFirebaseAuthMocks();

    tearDown(GetIt.I.reset);
    testWidgets('renders initial', (tester) async {
      await tester.pumpApp(const InformationScreen());

      expect(
        find.byKey(KWidgetkeys.screen.information.screen),
        findsOneWidget,
      );

      await tester.pumpAndSettle();

      await newsCardHelper(tester: tester);
    });
    group('Mock Go Router', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('renders initial', (tester) async {
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

      // group('go to', () {
      // });
    });
  });
}
