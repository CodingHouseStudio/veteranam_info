import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> wrongCodeNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(PasswordResetKeys.confirmButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: PasswordResetKeys.confirmButton,
  );

  await tester.tap(find.byKey(PasswordResetKeys.confirmButton));

  await tester.pumpAndSettle();

  verify(
    () => mockGoRouter.goNamed(KRoute.forgotPassword.name),
  ).called(1);
}
