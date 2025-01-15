import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> dialogSnackBarTextHelper({
  required WidgetTester tester,
  bool showDialog = true,
}) async {
  //final matcher = isFailure ? findsOneWidget : findsNothing;
  // expect(find.byKey(DialogsKeys.failure), matcher);

  // expect(find.byKey(DialogsKeys.failureButton), findsNothing);

  expect(
    find.byKey(DialogsKeys.snackBarText),
    showDialog ? findsOneWidget : findsNothing,
  );
}
