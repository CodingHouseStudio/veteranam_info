import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> reportDialogCheckEnterHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.widget.reportDialog.checkPoint),
    findsWidgets,
  );

  expect(find.byKey(KWidgetkeys.widget.checkPoint.icon), findsNothing);

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.reportDialog.checkPoint,
    first: false,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.checkPoint.widget).last,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.reportDialog.sendButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.reportDialog.sendButton,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.reportDialog.sendButton));

  await tester.pumpAndSettle();
}
