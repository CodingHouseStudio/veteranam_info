import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

Future<void> checkPointHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.questionsForm.roleVeteran),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.questionsForm.roleBusinessmen),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.questionsForm.roleCivilian),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.questionsForm.roleRelativeOfVeteran),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.screen.questionsForm.roleCivilian),
  );

  await tester.pumpAndSettle();

  await tester.tap(
    find.byKey(KWidgetkeys.screen.questionsForm.roleBusinessmen),
  );

  await tester.pumpAndSettle();

  await tester.tap(
    find.byKey(KWidgetkeys.screen.questionsForm.roleRelativeOfVeteran),
  );

  await tester.pumpAndSettle();

  await tester.tap(
    find.byKey(KWidgetkeys.screen.questionsForm.roleVeteran),
  );

  await tester.pumpAndSettle();

  expect(find.byKey(KWidgetkeys.widget.checkPoint.icon), findsOneWidget);
}
