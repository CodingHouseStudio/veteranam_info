import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> userEmailSaveHelper({
  required WidgetTester tester,
  required String email,
}) async {
  expect(find.byKey(UserEmailDialogKeys.field), findsOneWidget);

  await scrollingHelper(
    tester: tester,
    itemKey: UserEmailDialogKeys.field,
  );

  await tester.enterText(
    find.byKey(UserEmailDialogKeys.field),
    email,
  );

  await tester.pumpAndSettle();

  expect(find.byKey(UserEmailDialogKeys.button), findsOneWidget);

  // await scrollingHelper(
  //   tester: tester,
  //   itemKey: UserEmailDialogKeys.button,
  // );

  await tester.tap(find.byKey(UserEmailDialogKeys.button));

  await tester.pumpAndSettle();
}
