import 'package:flutter_test/flutter_test.dart';

import '../test_dependency.dart';

/// COMMENT: Helpers adds common elements to all screens in tests
///
/// mockGoRouter sets if you want use go router
extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    WidgetTester tester, {
    required String? routeName,
  }) async {
    await appHelper(tester);

    if (routeName != null) {
      await footerButtonHelper(
        tester: tester,
        buttonKey: KTestVariables.getFooterKey(routeName),
      );
    }
  }
}
