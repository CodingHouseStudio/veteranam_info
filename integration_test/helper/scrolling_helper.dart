import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

/// COMMENT: Helpers for scroll screen in integration tests
///
/// offset sets the length of the scroll plus a value up and minus a value down
///
/// itemKey sets which widget will be scrolled to by its Key
Future<void> scrollingHelperInt({
  required WidgetTester tester,
  Offset? offset,
  Key? itemKey,
}) async {
  if (offset != null) {
    await tester.drag(
      find.byKey(KWidgetkeys.widget.scaffold.scroll),
      offset,
    );
    await tester.pumpAndSettle();
  }
  if (itemKey != null) {
    await tester.ensureVisible(find.byKey(itemKey).first);
    await tester.pumpAndSettle();
  }
}
