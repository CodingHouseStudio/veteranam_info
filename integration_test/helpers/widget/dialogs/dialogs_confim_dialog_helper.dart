import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> dialogConfirmHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.widget.confirmDialog.confirmButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.confirmDialog.confirmButton));

  await tester.pumpAndSettle();

  // verify(() => mockGoRouter.pop()).called(1);
}
