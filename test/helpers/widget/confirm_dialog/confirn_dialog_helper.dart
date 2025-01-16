import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> confirmDialogHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
  bool isPop = true,
}) async {
  expect(
    find.byKey(ConfirmDialogKeys.confirmButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(ConfirmDialogKeys.confirmButton));

  await tester.pumpAndSettle();

  if (isPop) {
    expect(
      find.byKey(ConfirmDialogKeys.confirmButton),
      findsNothing,
    );
    // verify(() => mockGoRouter.pop(true)).called(1);
  }
}
