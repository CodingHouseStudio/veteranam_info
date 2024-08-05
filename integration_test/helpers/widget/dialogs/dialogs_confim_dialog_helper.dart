import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

Future<void> dialogConfirmHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.widget.dialogs.confirmButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.dialogs.confirmButton));

  await tester.pumpAndSettle();

  // verify(() => mockGoRouter.pop()).called(1);
}
