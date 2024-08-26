import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_dependency.dart';

Future<void> loadingFailureHelper({
  required WidgetTester tester,
  required Key card,
  required Key buttonMock,
}) async {
  expect(
    find.byKey(card),
    findsNothing,
  );

  expect(
    find.byKey(buttonMock),
    findsNothing,
  );

  await dialogFailureGetTapHelper(tester: tester);
}
