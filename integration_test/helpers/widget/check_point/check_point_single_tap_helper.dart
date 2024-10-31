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
    itemKey: KWidgetkeys.widget.checkPoint.widget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.checkPoint.widget),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.checkPoint.text),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.checkPoint.ammount),
    hasAmount ? findsWidgets : findsNothing,
  );

  await scrollingHelperInt(
    tester: tester,
    itemKey: KWidgetkeys.widget.checkPoint.widget,
    itemIndex: 3,
  );
  final keys = find.byKey(KWidgetkeys.widget.checkPoint.widget);

  await tester.tap(tapItemLast ? keys.at(3) : keys.first);
}
