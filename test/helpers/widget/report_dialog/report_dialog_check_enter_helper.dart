import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> reportDialogCheckEnterHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(ReportDialogKeys.checkPoint),
    findsWidgets,
  );

  expect(find.byKey(CheckPointKeys.icon), findsNothing);

  await scrollingHelper(
    tester: tester,
    itemKey: ReportDialogKeys.checkPoint,
    first: false,
  );

  await tester.tap(
    find.byKey(CheckPointKeys.widget).last,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(ReportDialogKeys.sendButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: ReportDialogKeys.sendButton,
  );

  await tester.tap(find.byKey(ReportDialogKeys.sendButton));

  await tester.pumpAndSettle();
}
