import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> deleteAccountConfirmButtonlHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(ProfileKeys.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();

  await profileDeleteButtonHelper(tester);

  await confirmDialogHelper(
    tester,
    isPop: false,
  );
}
