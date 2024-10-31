import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../helpers/helpers.dart';

Future<void> checkPointHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.questionsForm.roleVeteran),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.questionsForm.roleVeteran,
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
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  await tester.tap(
    find.byKey(KWidgetkeys.screen.questionsForm.roleBusinessmen),
  );

  await tester.pumpAndSettle();

  await tester.tap(
    find.byKey(KWidgetkeys.screen.questionsForm.roleRelativeOfVeteran),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  await tester.tap(
    find.byKey(KWidgetkeys.screen.questionsForm.roleVeteran),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  expect(find.byKey(KWidgetkeys.widget.checkPoint.icon), findsOneWidget);
}
