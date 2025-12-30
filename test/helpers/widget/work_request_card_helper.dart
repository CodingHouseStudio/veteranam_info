import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> workRequestCardHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(WorkRequestCardKeys.title), findsWidgets);

  expect(find.byKey(WorkRequestCardKeys.subtitle), findsWidgets);

  expect(find.byKey(WorkRequestCardKeys.button), findsWidgets);
}
