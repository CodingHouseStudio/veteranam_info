import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> reportDialogOpenHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.reportDialog.button,
    offset: KTestConstants.scrollingDown,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.reportDialog.button).first,
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  await reportDialogHelper(tester);
}
