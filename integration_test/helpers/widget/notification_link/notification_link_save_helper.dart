import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> notificationLinkSaveHelper({
  required WidgetTester tester,
  required String link,
}) async {
  expect(find.byKey(KWidgetkeys.widget.notificationLink.field), findsOneWidget);

  await scrollingHelperInt(
    tester: tester,
    itemKey: KWidgetkeys.widget.notificationLink.field,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.widget.notificationLink.field),
    link,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.notificationLink.button));

  await tester.pumpAndSettle();
}
