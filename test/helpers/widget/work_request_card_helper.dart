import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> workRequestCardHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.widget.workRequestCard.title), findsWidgets);

  expect(find.byKey(KWidgetkeys.widget.workRequestCard.subtitle), findsWidgets);

  expect(find.byKey(KWidgetkeys.widget.workRequestCard.button), findsWidgets);
}
