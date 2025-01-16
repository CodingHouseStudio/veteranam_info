import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> mobileLoadingHelper({
  required WidgetTester tester,
  required Key cardLast,
}) async {
  await tester.pumpAndSettle();

  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  expect(
    find.byKey(ScaffoldKeys.loadingButton),
    findsNothing,
  );

  expect(
    find.byKey(cardLast),
    findsNothing,
  );

  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  expect(
    find.byKey(cardLast),
    findsNothing,
  );
}
