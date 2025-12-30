import 'dart:ui';

import 'package:flutter/cupertino.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../test_dependency.dart';

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
  double elementScrollAligment = KTestConstants.scrollElemntVisialbeDefault,
  ScrollPositionAlignmentPolicy scrollPositionAlignmentPolicy =
      ScrollPositionAlignmentPolicy.explicit,
  PointerDeviceKind pointerDeviceKind = PointerDeviceKind.touch,
}) async {
  if (offset != null) {
    await tester.drag(
      find.byKey(scrollKey ?? ScaffoldKeys.scroll),
      offset,
      warnIfMissed: false,
      kind: pointerDeviceKind,
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
    await Scrollable.ensureVisible(
      _element(item),
      alignment: elementScrollAligment,
      alignmentPolicy: scrollPositionAlignmentPolicy,
    );
    // await tester.ensureVisible(
    //   item,
    // );
    await tester.pumpAndSettle();
  }
}

T _element<T extends Element>(FinderBase<Element> finder) {
  TestAsyncUtils.guardSync();
  return finder.evaluate().single as T;
}
