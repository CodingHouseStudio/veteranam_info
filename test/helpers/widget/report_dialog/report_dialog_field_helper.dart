import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

Future<void> reportDialogFieldHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.widget.reportDialog.emailField),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.reportDialog.messageField),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.reportDialog.sendButton),
    findsOneWidget,
  );
}
