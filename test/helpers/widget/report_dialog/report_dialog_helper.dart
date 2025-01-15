import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> reportDialogHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(ReportDialogKeys.title), findsOneWidget);

  expect(find.byKey(ReportDialogKeys.subtitle), findsOneWidget);

  expect(find.byKey(ReportDialogKeys.checkPoint), findsWidgets);

  // await chekPointHelper(tester: tester,twiceTap=false);

  expect(
    find.byKey(ReportDialogKeys.sendButton),
    findsOneWidget,
  );

  // expect(find.byKey(ReportDialogKeys.emailField),
  // findsNothing);

  expect(
    find.byKey(ReportDialogKeys.messageField),
    findsNothing,
  );

  // await tester.tapAt(Offset.zero);

  // await tester.pumpAndSettle();

  // expect(find.byKey(ReportDialogKeys.title), findsNothing);

  // expect(find.byKey(ReportDialogKeys.subtitle), findsNothing);

  // expect(find.byKey(ReportDialogKeys.checkPoint), findsNothing
  // );

  // expect(
  //   find.byKey(ReportDialogKeys.sendButton),
  //   findsNothing,
  // );

  // expect(
  //   find.byKey(ReportDialogKeys.widget),
  //   findsNothing,
  // );
}
