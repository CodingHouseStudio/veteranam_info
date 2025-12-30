import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> notificationLinkHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(NotificationLinkKeys.text),
    findsOneWidget,
  );

  expect(
    find.byKey(NotificationLinkKeys.field),
    findsOneWidget,
  );

  expect(
    find.byKey(NotificationLinkKeys.button),
    findsOneWidget,
  );

  expect(
    find.byKey(NotificationLinkKeys.thankText),
    findsNothing,
  );
}
