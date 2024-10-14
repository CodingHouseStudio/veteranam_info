import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

Future<void> dialogLogOutHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.widget.dialogs.logOut), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widget.dialogs.profileTitle), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widget.dialogs.confirmButton), findsOneWidget);

  expect(
    find.byKey(KWidgetkeys.widget.dialogs.unconfirmButton),
    findsOneWidget,
  );
}
