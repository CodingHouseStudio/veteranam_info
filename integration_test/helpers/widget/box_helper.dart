import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> boxHelper(
  WidgetTester tester,
) async {
  await scrollingHelperInt(
    tester: tester,
    itemKey: KWidgetkeys.widget.box.text,
  );

  expect(find.byKey(KWidgetkeys.widget.box.text), findsWidgets);

  expect(find.byKey(KWidgetkeys.widget.box.icon), findsWidgets);
}

/// FOLDER FILES COMMENT: Files for widgets test