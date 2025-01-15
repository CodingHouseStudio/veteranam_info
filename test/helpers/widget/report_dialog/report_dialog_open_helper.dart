import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> reportDialogOpenHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    itemKey: ReportDialogKeys.button,
    offset: KTestConstants.scrollingDown,
  );

  await tester.tap(
    find.byKey(ReportDialogKeys.button).first,
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  await reportDialogHelper(tester);
}
