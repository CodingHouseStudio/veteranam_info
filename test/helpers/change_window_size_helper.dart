import 'package:flutter_test/flutter_test.dart';

import '../text_dependency.dart';

/// COMMENT: Helpers change window size in tests
/// (Default value for setDefaultSize is false)
///
/// setDefaultSize if true sets screen size to initial screen size if false
/// tablet size
Future<void> changeWindowSizeHelper({
  required WidgetTester tester,
  bool setDefaultSize = false,
}) async {
  if (setDefaultSize) {
    await tester.binding.setSurfaceSize(null);
  } else {
    await tester.binding.setSurfaceSize(KTestConstants.windowTabletSize);
  }

  await tester.pump();
}
