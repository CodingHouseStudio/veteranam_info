import 'package:flutter_test/flutter_test.dart';

import '../../test_dependency.dart';

Future<void> myDiscountsEndListHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async => scaffoldEmptyScrollHelper(tester),
  );
}
