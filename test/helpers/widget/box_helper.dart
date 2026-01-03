import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> boxHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    itemKey: BoxKeys.text,
  );

  expect(find.byKey(BoxKeys.text), findsWidgets);

  expect(find.byKey(BoxKeys.icon), findsWidgets);
}

/// FOLDER FILES COMMENT: Files for widgets test
