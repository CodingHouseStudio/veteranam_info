import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

Future<void> chatInputHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.widget.chatInput.icon), findsWidgets);

  expect(find.byKey(KWidgetkeys.widget.chatInput.message), findsWidgets);
}
