import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> confirmDialogCancelIconHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(ConfirmDialogKeys.cancelIcon),
    findsOneWidget,
  );

  await tester.tap(find.byKey(ConfirmDialogKeys.cancelIcon));

  await tester.pumpAndSettle();

  expect(
    find.byKey(ConfirmDialogKeys.cancelIcon),
    findsNothing,
  );

  // verify(() => mockGoRouter.pop()).called(1);
}
