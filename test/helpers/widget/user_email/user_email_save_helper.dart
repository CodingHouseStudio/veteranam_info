import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> userEmailSaveHelper({
  required WidgetTester tester,
  required String email,
}) async {
  await userEmailHelper(tester);

  expect(find.byKey(KWidgetkeys.widget.userEmailDialog.field), findsOneWidget);

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.userEmailDialog.field,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.widget.userEmailDialog.field),
    email,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.userEmailDialog.button,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.userEmailDialog.button));

  await tester.pumpAndSettle();
}
