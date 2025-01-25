import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> mobUpdateDialogCloseButtonsHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await tester.pumpAndSettle();

  await mobUpdateDialogHelper(tester);

  expect(find.byKey(MobUpdateKeys.lateButton), findsWidgets);

  expect(find.byKey(MobUpdateKeys.updateButton), findsWidgets);

  await tester.tap(find.byKey(MobUpdateKeys.updateButton));

  await tester.pumpAndSettle();

  await mobUpdateDialogHelper(tester, isOpened: false);
}
