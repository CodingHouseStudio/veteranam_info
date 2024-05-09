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
      await tester.pumpApp(const WorkRespondScreen());

      expect(
        find.byKey(KWidgetkeys.screen.workRespond.screen),
        findsOneWidget,
      );

      await tester.pumpAndSettle();

      expect(
        find.byKey(KWidgetkeys.screen.workRespond.title),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.workRespond.subtitle),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.workRespond.username),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.workRespond.emailText),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.workRespond.emailField),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.workRespond.phoneNumberText),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.workRespond.phoneNumberField),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.workRespond.resume),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.workRespond.upload),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.workRespond.checkPoint),
        findsOneWidget,
      );

      await chekPointSingleHelper(tester);

      expect(
        find.byKey(KWidgetkeys.screen.workRespond.noResume),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.workRespond.send),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.workRespond.cancel),
        findsOneWidget,
      );
    });
    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.intial} ', (tester) async {
        await tester.pumpApp(
          const WorkRespondScreen(),
          mockGoRouter: mockGoRouter,
        );

        expect(
          find.byKey(KWidgetkeys.screen.workRespond.screen),
          findsOneWidget,
        );
        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.screen.workRespond.title),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.workRespond.subtitle),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.workRespond.username),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.workRespond.emailText),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.workRespond.emailField),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.workRespond.phoneNumberText),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.workRespond.phoneNumberField),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.workRespond.resume),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.workRespond.upload),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.workRespond.checkPoint),
          findsOneWidget,
        );

        await chekPointSingleHelper(tester);

        expect(
          find.byKey(KWidgetkeys.screen.workRespond.noResume),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.workRespond.send),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.workRespond.cancel),
          findsOneWidget,
        );
      });
      // group('${KGroupText.goTo} ', () {
      // });
    });
  });
}
