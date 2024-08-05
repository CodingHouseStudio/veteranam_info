import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

/// COMMENT: Helpers for scroll screen in tests
///
/// offset sets the length of the scroll plus a value up and minus a value down
///
/// itemKey sets which widget will be scrolled to by its Key
///
/// itemFinder sets which widget will be scrolled to by its Finder
Future<void> scrollingHelperInt({
  required WidgetTester tester,
  Key? itemKey,
  Key? scrollKey,
  Offset? offset,
  bool first = true,
}) async {
  if (offset != null) {
    await tester.drag(
      find.byKey(scrollKey ?? KWidgetkeys.widget.scaffold.scroll),
      offset,
      warnIfMissed: false,
    );
    await tester.pumpAndSettle();
  }
  if (itemKey != null) {
    await tester.ensureVisible(
      first ? find.byKey(itemKey).first : find.byKey(itemKey).last,
    );
    await tester.pumpAndSettle();
  }
}
