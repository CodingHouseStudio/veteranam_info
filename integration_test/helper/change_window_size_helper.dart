import 'package:flutter_test/flutter_test.dart';

import '../test_dependency.dart';

/// COMMENT: Helpers change window size in integration tests
/// (Default value for setDefaultSize is false)
///
/// setDefaultSize if true sets screen size to initial screen size if false
/// mobile size
Future<void> changeWindowSizeHelperInt({
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
