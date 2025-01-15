import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> reportDialogCheckFailureHelper(
  WidgetTester tester,
) async {
  await reportDialogOpenHelper(tester);

  expect(
    find.byKey(ReportDialogKeys.checkPointError),
    findsNothing,
  );

  expect(
    find.byKey(ReportDialogKeys.checkPoint),
    findsWidgets,
  );

  expect(find.byKey(CheckPointKeys.icon), findsNothing);

  expect(
    find.byKey(ReportDialogKeys.sendButton),
    findsOneWidget,
  );

  await scrollingHelperInt(
    tester: tester,
    itemKey: ReportDialogKeys.sendButton,
  );

  await tester.tap(find.byKey(ReportDialogKeys.sendButton));

  await tester.pumpAndSettle();

  expect(
    find.byKey(ReportDialogKeys.checkPointError),
    findsOneWidget,
  );
}
