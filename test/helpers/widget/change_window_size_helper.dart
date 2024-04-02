import 'package:flutter_test/flutter_test.dart';

import '../../constants.dart';

Future<void> changeWindowSizeHelper({
  required WidgetTester tester,
  bool setDefaultSize = false,
}) async {
  if (setDefaultSize) {
    await tester.binding.setSurfaceSize(null);
  } else {
    await tester.binding.setSurfaceSize(KTestData.windowTableetSize);
  }

  await tester.pumpAndSettle();
}
