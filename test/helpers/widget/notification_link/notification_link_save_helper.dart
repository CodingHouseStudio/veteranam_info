import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';

Future<void> notificationLinkSaveHelper({
  required WidgetTester tester,
  required String link,
}) async {
  expect(find.byKey(NotificationLinkKeys.field), findsOneWidget);

  await scrollingHelper(
    tester: tester,
    itemKey: NotificationLinkKeys.field,
  );

  await tester.enterText(
    find.byKey(NotificationLinkKeys.field),
    link,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: NotificationLinkKeys.button,
  );

  await tester.tap(find.byKey(NotificationLinkKeys.button));

  await tester.pumpAndSettle();
}
