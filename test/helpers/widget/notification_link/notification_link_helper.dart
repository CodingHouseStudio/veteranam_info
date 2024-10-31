import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> notificationLinkHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.widget.notificationLink.text),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.notificationLink.field),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.notificationLink.button),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.notificationLink.thankText),
    findsNothing,
  );
}
