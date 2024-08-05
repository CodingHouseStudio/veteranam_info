import 'package:flutter_test/flutter_test.dart';

import '../test_dependency.dart';

/// COMMENT: Helpers change window size in tests
/// (Default value for setDefaultSize is false)
///
/// setDefaultSize if true sets screen size to initial screen size if false
/// tablet size
Future<void> changeWindowSizeHelper({
  required WidgetTester tester,
  required Future<void> Function() test,
}) async {
  await tester.binding.setSurfaceSize(KTestConstants.windowDeskSize);

  await tester.pumpAndSettle();

  await test();

  await tester.binding.setSurfaceSize(null);

  await tester.pumpAndSettle();
}

/// FOLDER FILES COMMENT: Files for widgets test or helper for test
