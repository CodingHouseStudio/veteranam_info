import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> dialogHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(ConfirmDialogKeys.title), findsOneWidget);

  expect(
    find.byKey(ConfirmDialogKeys.confirmButton),
    findsOneWidget,
  );

  expect(
    find.byKey(ConfirmDialogKeys.unconfirmButton),
    findsOneWidget,
  );
}
