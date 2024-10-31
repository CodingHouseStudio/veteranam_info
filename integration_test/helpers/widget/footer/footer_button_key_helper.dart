import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> footerButtonHelper({
  required WidgetTester tester,
  required Key buttonKey,
}) async {
  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  await scrollingHelperInt(
    tester: tester,
    itemKey: KWidgetkeys.widget.footer.title,
    offset: KTestConstants.scrollingUp200,
  );

  expect(
    find.byKey(buttonKey),
    findsOneWidget,
  );

  await tester.tap(find.byKey(buttonKey));

  await tester.pumpAndSettle();
}
