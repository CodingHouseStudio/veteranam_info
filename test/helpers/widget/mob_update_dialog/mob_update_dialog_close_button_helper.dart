import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';

Future<void> mobUpdateDialogApplyButtonsHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await tester.pumpAndSettle();

  await mobUpdateDialogHelper(tester);

  expect(find.byKey(MobUpdateKeys.lateButton), findsWidgets);

  await tester.tap(find.byKey(MobUpdateKeys.lateButton));

  await tester.pumpAndSettle();

  await mobUpdateDialogHelper(tester, isOpened: false);
}
