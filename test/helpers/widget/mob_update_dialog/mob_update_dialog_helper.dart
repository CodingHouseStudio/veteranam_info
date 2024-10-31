import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> mobUpdateDialogHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.widget.mobUpdate.dialog), findsWidgets);

  expect(find.byKey(KWidgetkeys.widget.mobUpdate.title), findsWidgets);

  expect(find.byKey(KWidgetkeys.widget.mobUpdate.description), findsWidgets);

  expect(find.byKey(KWidgetkeys.widget.mobUpdate.lateButton), findsWidgets);

  expect(find.byKey(KWidgetkeys.widget.mobUpdate.updateButton), findsWidgets);
}
