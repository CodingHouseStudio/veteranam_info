import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> mobUpdateDialogButtonsHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await mobUpdateDialogHelper(tester);

  expect(find.byKey(MobUpdateKeys.lateButton), findsWidgets);

  await tester.tap(find.byKey(MobUpdateKeys.lateButton));

  verify(() => mockGoRouter.pop()).called(1);

  expect(find.byKey(MobUpdateKeys.updateButton), findsWidgets);

  await tester.tap(find.byKey(MobUpdateKeys.updateButton));

  verify(() => mockGoRouter.pop()).called(1);
}
