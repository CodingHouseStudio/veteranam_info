import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> rateHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.rate.title,
  );

  expect(find.byKey(KWidgetkeys.widget.rate.ratingBarIcons), findsWidgets);
}
