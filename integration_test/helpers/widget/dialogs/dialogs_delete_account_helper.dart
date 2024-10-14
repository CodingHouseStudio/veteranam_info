import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

Future<void> dialogDeleteAccountHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.widget.dialogs.deleteAccount), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widget.dialogs.profileTitle), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widget.dialogs.confirmButton), findsOneWidget);

  expect(
    find.byKey(KWidgetkeys.widget.dialogs.unconfirmButton),
    findsOneWidget,
  );
}
