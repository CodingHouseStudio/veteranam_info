import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> hoverHelper({
  required WidgetTester tester,
  required Key key,
  Key? hoverElement,
  int index = 0,
  bool usePump = false,
}) async {
  final widgetLocation = tester.getCenter(
    find.byKey(key).at(index),
  );

  final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);

  await gesture.addPointer(location: widgetLocation);

  if (usePump) {
    await tester.pump();
  } else {
    await tester.pumpAndSettle();
  }

  if (hoverElement != null) {
    expect(
      find.byKey(hoverElement),
      findsOneWidget,
    );
  }

  await gesture.removePointer(location: widgetLocation);

  if (usePump) {
    await tester.pump();
  } else {
    await tester.pumpAndSettle();
  }

  if (hoverElement != null) {
    expect(
      find.byKey(hoverElement),
      findsNothing,
    );
  }
}
