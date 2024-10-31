import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> dialogSnackBarTextHelper({
  required WidgetTester tester,
  bool showDialog = true,
}) async {
  //final matcher = showDialog ? findsOneWidget : findsNothing;

  // expect(find.byKey(KWidgetkeys.widget.dialogs.failure), matcher);

  // expect(find.byKey(KWidgetkeys.widget.dialogs.failureButton), findsNothing);

  expect(
    find.byKey(KWidgetkeys.widget.dialogs.snackBarText),
    showDialog ? findsOneWidget : findsNothing,
  );
}
