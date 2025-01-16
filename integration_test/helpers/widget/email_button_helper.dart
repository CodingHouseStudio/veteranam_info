import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

// import '../helpers.dart';

Future<void> emailButtonHelperInt(
  WidgetTester tester,
) async {
  expect(
    find.byKey(EmailButtonKeys.text),
    findsWidgets,
  );
  expect(
    find.byKey(EmailButtonKeys.icon),
    findsWidgets,
  );
  // await tester.tap(find.byKey(EmailButtonKeys.text));

  // await tester.pumpAndSettle();

  // await dialogSnackBarTextHelper(tester: tester);
}
