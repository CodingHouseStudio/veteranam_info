import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> notificationLinkThankTextHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(NotificationLinkKeys.thankText),
    findsOneWidget,
  );
}
