import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> rateHelper(
  WidgetTester tester,
) async {
  await scrollingHelperInt(
    tester: tester,
    itemKey: KWidgetkeys.widget.rate.title,
  );

  expect(find.byKey(KWidgetkeys.widget.rate.ratingBarIcons), findsWidgets);
}
