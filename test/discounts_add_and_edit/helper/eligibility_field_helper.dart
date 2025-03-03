import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> eligibilityFieldHelper({
  required WidgetTester tester,
  int fieldIndex = 0,
  bool hasValue = false,
  bool removeAfter = true,
}) async {
  expect(
    find.byKey(DiscountsAddKeys.eligibilityField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: DiscountsAddKeys.eligibilityField,
  );

  expect(
    find.byKey(DiscountsAddKeys.eligibilityField),
    findsOneWidget,
  );

  expect(
    find.byKey(DiscountsAddKeys.eligibilityItems),
    findsNothing,
  );

  expect(
    find.byKey(DiscountsAddKeys.eligibilityActiveItems),
    hasValue ? findsWidgets : findsNothing,
  );

  await tester.tap(
    find.byKey(DiscountsAddKeys.eligibilityField),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(DiscountsAddKeys.eligibilityItems),
    findsWidgets,
  );

  await tester.tap(
    find.byKey(DiscountsAddKeys.eligibilityItems).first,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(DiscountsAddKeys.eligibilityItems),
    findsNothing,
  );

  expect(
    find.byKey(DiscountsAddKeys.eligibilityActiveItems),
    findsWidgets,
  );

  if (removeAfter) {
    await tester.tap(
      find.byKey(DiscountsAddKeys.eligibilityActiveItems).last,
    );

    await tester.pumpAndSettle();
  }
}
