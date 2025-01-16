import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> confirmDialogUnconfirmHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(ConfirmDialogKeys.unconfirmButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(ConfirmDialogKeys.unconfirmButton));

  await tester.pumpAndSettle();

  expect(
    find.byKey(ConfirmDialogKeys.unconfirmButton),
    findsNothing,
  );

  // verify(() => mockGoRouter.pop(false)).called(1);
}
