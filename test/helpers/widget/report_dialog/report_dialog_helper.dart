import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

Future<void> reportDialogHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.widget.reportDialog.title), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widget.reportDialog.subtitle), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widget.reportDialog.checkPoint), findsWidgets);

  // await chekPointHelper(tester: tester,twiceTap=false);

  expect(
    find.byKey(KWidgetkeys.widget.reportDialog.sendButton),
    findsOneWidget,
  );

  // expect(find.byKey(KWidgetkeys.widget.reportDialog.emailField),
  // findsNothing);

  expect(
    find.byKey(KWidgetkeys.widget.reportDialog.messageField),
    findsNothing,
  );

  // await tester.tapAt(Offset.zero);

  // await tester.pumpAndSettle();

  // expect(find.byKey(KWidgetkeys.widget.reportDialog.title), findsNothing);

  // expect(find.byKey(KWidgetkeys.widget.reportDialog.subtitle), findsNothing);

  // expect(find.byKey(KWidgetkeys.widget.reportDialog.checkPoint), findsNothing
  // );

  // expect(
  //   find.byKey(KWidgetkeys.widget.reportDialog.sendButton),
  //   findsNothing,
  // );

  // expect(
  //   find.byKey(KWidgetkeys.widget.reportDialog.widget),
  //   findsNothing,
  // );
}
