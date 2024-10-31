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
    itemKey: KWidgetkeys.widget.checkPoint.widget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.checkPoint.widget),
    findsWidgets,
  );

  if (!customText) {
    expect(
      find.byKey(KWidgetkeys.widget.checkPoint.text),
      findsWidgets,
    );
  }

  expect(
    find.byKey(KWidgetkeys.widget.checkPoint.ammount),
    hasAmount ? findsWidgets : findsNothing,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.checkPoint.widget,
    itemIndex: index,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.checkPoint.widget).at(index));

  await tester.pumpAndSettle();
}
