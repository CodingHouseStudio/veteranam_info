import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> chatInputHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.widget.chatInput.icon), findsWidgets);

  expect(find.byKey(KWidgetkeys.widget.chatInput.message), findsWidgets);
}
