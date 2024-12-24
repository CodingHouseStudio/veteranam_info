import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

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
  Key? scrollKey,
  Offset? offset,
  bool first = true,
  int? itemIndex,
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
    final finder = find.byKey(itemKey);
    final item = itemIndex != null
        ? finder.at(itemIndex)
        : first
            ? finder.first
            : finder.last;
    expect(item, findsOneWidget);
    await tester.ensureVisible(
      item,
    );
    await tester.pumpAndSettle();
  }
}
