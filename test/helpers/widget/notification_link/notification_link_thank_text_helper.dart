import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

Future<void> notificationLinkThankTextHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.widget.notificationLink.thankText),
    findsOneWidget,
  );
}
