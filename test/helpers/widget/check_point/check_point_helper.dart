import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> chekPointHelper({
  required WidgetTester tester,
  bool hasAmount = false,
  bool twiceTap = true,
}) async {
  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.checkPoint.widget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.checkPoint.widget),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.checkPoint.icon),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.checkPoint.text),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.checkPoint.ammount),
    hasAmount ? findsWidgets : findsNothing,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.checkPoint.widget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.checkPoint.widget).first);

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.checkPoint.icon),
    findsOneWidget,
  );

  if (twiceTap) {
    await tester.tap(find.byKey(KWidgetkeys.widget.checkPoint.widget).first);

    await tester.pumpAndSettle();

    expect(
      find.byKey(KWidgetkeys.widget.checkPoint.icon),
      findsNothing,
    );
  } else {
    await tester.tap(find.byKey(KWidgetkeys.widget.checkPoint.widget).first);

    await tester.pumpAndSettle();

    expect(
      find.byKey(KWidgetkeys.widget.checkPoint.icon),
      findsOneWidget,
    );
  }
}
