import 'package:flutter_test/flutter_test.dart';

import '../../../test_dependency.dart';

Future<void> nawbarNavigationHelper(
  WidgetTester tester,
) async {
  await nawbarTitleHelper(
    tester,
  );

  await nawbarLoginNavigationHelper(
    tester,
  );
}
