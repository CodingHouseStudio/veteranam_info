import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

// import '../helpers.dart';

Future<void> emailButtonHelperInt(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.widget.emailButton.text),
    findsWidgets,
  );
  expect(
    find.byKey(KWidgetkeys.widget.emailButton.icon),
    findsWidgets,
  );
  // await tester.tap(find.byKey(KWidgetkeys.widget.emailButton.text));

  // await tester.pumpAndSettle();

  // await dialogSnackBarTextHelper(tester: tester);
}