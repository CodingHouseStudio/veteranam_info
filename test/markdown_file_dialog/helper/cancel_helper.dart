import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> cancelHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(KWidgetkeys.screen.privacyPolicy.closeIcon),
    findsWidgets,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.privacyPolicy.closeIcon));

  verify(
    () => mockGoRouter.pop(),
  ).called(1);
}
