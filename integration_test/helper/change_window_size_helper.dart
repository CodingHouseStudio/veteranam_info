import 'package:flutter_test/flutter_test.dart';

import '../test_dependency.dart';

Future<void> changeWindowSizeHelper({
  required WidgetTester tester,
  bool setDefaultSize = false,
}) async {
  if (setDefaultSize) {
    await tester.binding.setSurfaceSize(null);
  } else {
    await tester.binding.setSurfaceSize(KTestConstants.windowMobileSize);
  }

  await tester.pump();
}
