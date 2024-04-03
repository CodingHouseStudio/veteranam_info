import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

Future<void> changeWindowSizeHelper({
  required WidgetTester tester,
  Size? windowSize,
}) async {
  if (windowSize == null) {
    await tester.binding.setSurfaceSize(null);
  } else {
    await tester.binding.setSurfaceSize(windowSize);
  }

  await tester.pumpAndSettle();
}
