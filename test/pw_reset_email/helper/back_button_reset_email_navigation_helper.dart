import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';
import 'form/emial_correct_helper.dart';

Future<void> backButtonResetEmailNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await emailCorrectHelper(tester);

  expect(
    find.byKey(KWidgetkeys.screen.pwResetEmail.cancelButton),
    findsWidgets,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.pwResetEmail.cancelButton));

  await tester.pumpAndSettle();
}
