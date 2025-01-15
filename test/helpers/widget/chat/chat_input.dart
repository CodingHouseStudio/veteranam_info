import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> chatInputHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(ChatInputKeys.icon), findsWidgets);

  expect(find.byKey(ChatInputKeys.message), findsWidgets);
}
