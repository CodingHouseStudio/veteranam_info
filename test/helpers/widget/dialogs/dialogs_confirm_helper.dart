import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

Future<void> dialogConfirmChangesHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.widget.dialogs.icon), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widget.dialogs.title), findsOneWidget);

  expect(
    find.byKey(KWidgetkeys.widget.dialogs.subtitle),
    findsOneWidget,
  );

  expect(find.byKey(KWidgetkeys.widget.dialogs.confirmButton), findsOneWidget);

  expect(
    find.byKey(KWidgetkeys.widget.dialogs.unconfirmButton),
    findsOneWidget,
  );
}
