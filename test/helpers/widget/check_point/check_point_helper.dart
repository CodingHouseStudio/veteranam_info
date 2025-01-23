import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> chekPointHelper({
  required WidgetTester tester,
  bool hasAmount = false,
  bool twiceTap = true,
  bool isEmpty = true,
}) async {
  await scrollingHelper(
    tester: tester,
    itemKey: CheckPointKeys.widget,
  );

  expect(
    find.byKey(CheckPointKeys.widget),
    findsWidgets,
  );

  expect(
    find.byKey(CheckPointKeys.icon),
    isEmpty ? findsNothing : findsOneWidget,
  );

  expect(
    find.byKey(CheckPointKeys.text),
    findsWidgets,
  );

  expect(
    find.byKey(CheckPointKeys.ammount),
    hasAmount ? findsWidgets : findsNothing,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: CheckPointKeys.widget,
  );

  await tester.tap(find.byKey(CheckPointKeys.widget).first);

  await tester.pumpAndSettle();

  expect(
    find.byKey(CheckPointKeys.icon),
    findsOneWidget,
  );

  if (twiceTap) {
    await tester.tap(find.byKey(CheckPointKeys.widget).first);

    await tester.pumpAndSettle();

    // expect(
    //   find.byKey(CheckPointKeys.icon),
    //   findsNothing,
    // );
  } else {
    await tester.tap(find.byKey(CheckPointKeys.widget).first);

    await tester.pumpAndSettle();

    expect(
      find.byKey(CheckPointKeys.icon),
      findsOneWidget,
    );
  }
}
