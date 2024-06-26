import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../../text_dependency.dart';

Future<void> reportDialogOpenHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.reportDialog.button,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.reportDialog.button).first);

  await tester.pumpAndSettle();
}
