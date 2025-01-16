import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> dialogUnconfirmHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(ConfirmDialogKeys.unconfirmButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(ConfirmDialogKeys.unconfirmButton));

  await tester.pumpAndSettle();

  // verify(() => mockGoRouter.pop()).called(1);
}
