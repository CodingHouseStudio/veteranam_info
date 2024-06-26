import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../../text_dependency.dart';

Future<void> reportDialogInitialHelper(
  WidgetTester tester,
) async {
  await reportDialogOpenHelper(tester);

  expect(find.byKey(KWidgetkeys.widget.reportDialog.title), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widget.reportDialog.subtitle), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widget.reportDialog.checkPoint), findsWidgets);

  expect(
    find.byKey(KWidgetkeys.widget.reportDialog.sendButton),
    findsOneWidget,
  );

  expect(find.byKey(KWidgetkeys.widget.reportDialog.emailField), findsNothing);

  expect(
    find.byKey(KWidgetkeys.widget.reportDialog.messageField),
    findsNothing,
  );
}
