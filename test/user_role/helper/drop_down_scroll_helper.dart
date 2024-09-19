import 'package:flutter_test/flutter_test.dart';

import '../../test_dependency.dart';

Future<void> dropDownScrollHelper({
  required WidgetTester tester,
  required Future<void> Function() test,
}) async {
  await scrollingHelper(tester: tester, offset: KTestConstants.scrollingDown);

  await test();
}
