import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

Future<void> dialogHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.widget.dialogs.title), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widget.dialogs.confirmButton), findsOneWidget);

  expect(
    find.byKey(KWidgetkeys.widget.dialogs.unconfirmButton),
    findsOneWidget,
  );
}
