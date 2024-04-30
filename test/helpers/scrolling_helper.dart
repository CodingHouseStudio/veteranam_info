import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

/// COMMENT: Helpers for scroll screen in tests
///
/// offset sets the length of the scroll plus a value up and minus a value down
///
/// itemKey sets which widget will be scrolled to by its Key
///
/// itemFinder sets which widget will be scrolled to by its Finder
Future<void> scrollingHelper({
  required WidgetTester tester,
  Key? itemKey,
  Finder? itemFinder,
  Offset? offset,
}) async {
  if (offset != null) {
    await tester.drag(find.byKey(KWidgetkeys.widget.shellRoute.scroll), offset);
    await tester.pumpAndSettle();
  }
  if (itemKey != null || itemFinder != null) {
    await tester.ensureVisible(itemFinder ?? find.byKey(itemKey!).first);
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
  }
}
