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
  group('${KScreenBlocName.workRespond} ', () {
    testWidgets('${KGroupText.intial} ', (tester) async {
      await tester.pumpApp(const EmployeeRespondScreen());

      expect(
        find.byKey(KWidgetkeys.screen.employeeRespond.screen),
        findsOneWidget,
      );

      await tester.pumpAndSettle();

      expect(
        find.byKey(KWidgetkeys.screen.employeeRespond.title),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employeeRespond.subtitle),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employeeRespond.username),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employeeRespond.emailText),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employeeRespond.emailField),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employeeRespond.phoneNumberText),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employeeRespond.phoneNumberField),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employeeRespond.resume),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employeeRespond.upload),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employeeRespond.checkPoint),
        findsOneWidget,
      );

      await chekPointSingleHelper(tester);

      expect(
        find.byKey(KWidgetkeys.screen.employeeRespond.noResume),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employeeRespond.send),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employeeRespond.cancel),
        findsOneWidget,
      );
    });
    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.intial} ', (tester) async {
        await tester.pumpApp(
          const EmployeeRespondScreen(),
          mockGoRouter: mockGoRouter,
        );

        expect(
          find.byKey(KWidgetkeys.screen.employeeRespond.screen),
          findsOneWidget,
        );
        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.screen.employeeRespond.title),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.employeeRespond.subtitle),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.employeeRespond.username),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.employeeRespond.emailText),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.employeeRespond.emailField),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.employeeRespond.phoneNumberText),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.employeeRespond.phoneNumberField),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.employeeRespond.resume),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.employeeRespond.upload),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.employeeRespond.checkPoint),
          findsOneWidget,
        );

        await chekPointSingleHelper(tester);

        expect(
          find.byKey(KWidgetkeys.screen.employeeRespond.noResume),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.employeeRespond.send),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.employeeRespond.cancel),
          findsOneWidget,
        );
      });
    });
  });
}
