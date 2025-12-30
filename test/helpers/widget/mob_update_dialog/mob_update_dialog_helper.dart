import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> mobUpdateDialogHelper(
  WidgetTester tester, {
  bool isOpened = true,
}) async {
  final matcher = isOpened ? findsOneWidget : findsNothing;

  expect(find.byKey(MobUpdateKeys.dialog), matcher);

  expect(find.byKey(MobUpdateKeys.title), matcher);

  expect(find.byKey(MobUpdateKeys.description), matcher);

  expect(find.byKey(MobUpdateKeys.lateButton), matcher);

  expect(find.byKey(MobUpdateKeys.updateButton), matcher);
}
