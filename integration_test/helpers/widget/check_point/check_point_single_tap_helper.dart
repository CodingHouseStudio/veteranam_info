import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> chekPointSignleTapHelper({
  required WidgetTester tester,
  bool hasAmount = false,
  bool tapItemLast = false,
}) async {
  await scrollingHelperInt(
    tester: tester,
    itemKey: CheckPointKeys.widget,
  );

  expect(
    find.byKey(CheckPointKeys.widget),
    findsWidgets,
  );

  expect(
    find.byKey(CheckPointKeys.text),
    findsWidgets,
  );

  expect(
    find.byKey(CheckPointKeys.ammount),
    hasAmount ? findsWidgets : findsNothing,
  );

  await scrollingHelperInt(
    tester: tester,
    itemKey: CheckPointKeys.widget,
    itemIndex: 3,
  );
  final keys = find.byKey(CheckPointKeys.widget);

  await tester.tap(tapItemLast ? keys.at(3) : keys.first);
}
