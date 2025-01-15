import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> chekPointSignleTapHelper({
  required WidgetTester tester,
  bool hasAmount = false,
  bool customText = false,
  int index = 0,
}) async {
  await scrollingHelper(
    tester: tester,
    itemKey: CheckPointKeys.widget,
  );

  expect(
    find.byKey(CheckPointKeys.widget),
    findsWidgets,
  );

  if (!customText) {
    expect(
      find.byKey(CheckPointKeys.text),
      findsWidgets,
    );
  }

  expect(
    find.byKey(CheckPointKeys.ammount),
    hasAmount ? findsWidgets : findsNothing,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: CheckPointKeys.widget,
    itemIndex: index,
  );

  await tester.tap(find.byKey(CheckPointKeys.widget).at(index));

  await tester.pumpAndSettle();
}
