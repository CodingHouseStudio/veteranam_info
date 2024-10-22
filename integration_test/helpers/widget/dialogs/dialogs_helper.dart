import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

Future<void> dialogHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.widget.confirmDialog.title), findsOneWidget);

  expect(
    find.byKey(KWidgetkeys.widget.confirmDialog.confirmButton),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.confirmDialog.unconfirmButton),
    findsOneWidget,
  );
}
