import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../helpers/helpers.dart';

Future<void> checkPointHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(QuestionsFormKeys.roleVeteran),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: QuestionsFormKeys.roleVeteran,
  );

  expect(
    find.byKey(QuestionsFormKeys.roleBusinessmen),
    findsOneWidget,
  );

  expect(
    find.byKey(QuestionsFormKeys.roleCivilian),
    findsOneWidget,
  );

  expect(
    find.byKey(QuestionsFormKeys.roleRelativeOfVeteran),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(QuestionsFormKeys.roleCivilian),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  await tester.tap(
    find.byKey(QuestionsFormKeys.roleBusinessmen),
  );

  await tester.pumpAndSettle();

  await tester.tap(
    find.byKey(QuestionsFormKeys.roleRelativeOfVeteran),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  await tester.tap(
    find.byKey(QuestionsFormKeys.roleVeteran),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  expect(find.byKey(CheckPointKeys.icon), findsOneWidget);
}
