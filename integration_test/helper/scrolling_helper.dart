import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

Future<void> scrollingHelper({
  required WidgetTester tester,
  Offset? offset,
  Key? itemKey,
}) async {
  if (offset != null) {
    await tester.drag(find.byKey(KWidgetkeys.widget.shellRoute.scroll), offset);
  }
  await tester.pumpAndSettle();
  if (itemKey != null) {
    await tester.ensureVisible(find.byKey(itemKey));
  }
  await tester.pumpAndSettle();
}
