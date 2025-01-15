import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> mobUpdateDialogHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(MobUpdateKeys.dialog), findsWidgets);

  expect(find.byKey(MobUpdateKeys.title), findsWidgets);

  expect(find.byKey(MobUpdateKeys.description), findsWidgets);

  expect(find.byKey(MobUpdateKeys.lateButton), findsWidgets);

  expect(find.byKey(MobUpdateKeys.updateButton), findsWidgets);
}
