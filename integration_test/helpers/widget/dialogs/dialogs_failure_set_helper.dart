import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

Future<void> dialogFailureSetHelper({
  required WidgetTester tester,
  bool isFailure = true,
}) async {
  final matcher = isFailure ? findsOneWidget : findsNothing;
  expect(find.byKey(KWidgetkeys.widget.dialogs.failure), matcher);

  expect(find.byKey(KWidgetkeys.widget.dialogs.failureButton), findsNothing);

  expect(find.byKey(KWidgetkeys.widget.dialogs.failureText), matcher);
}
