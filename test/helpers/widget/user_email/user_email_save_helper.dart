import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> userEmailSaveHelper({
  required WidgetTester tester,
  required String email,
}) async {
  expect(find.byKey(KWidgetkeys.widget.userEmailDialog.field), findsOneWidget);

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.userEmailDialog.field,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.widget.userEmailDialog.field),
    email,
  );

  await tester.pumpAndSettle();

  expect(find.byKey(KWidgetkeys.widget.userEmailDialog.button), findsOneWidget);

  // await scrollingHelper(
  //   tester: tester,
  //   itemKey: KWidgetkeys.widget.userEmailDialog.button,
  // );

  await tester.tap(find.byKey(KWidgetkeys.widget.userEmailDialog.button));

  await tester.pumpAndSettle();
}
