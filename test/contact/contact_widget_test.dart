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
  group(KScreenBlocName.contact, () {
    testWidgets('renders initial', (tester) async {
      await tester.pumpApp(const ContactScreen());

      expect(
        find.byKey(KWidgetkeys.screen.contact.screen),
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
        await tester.pumpApp(
          const ContactScreen(),
          mockGoRouter: mockGoRouter,
        );

        expect(
          find.byKey(KWidgetkeys.screen.contact.screen),
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
      // group('go to', () {
      // });
    });
  });
}
