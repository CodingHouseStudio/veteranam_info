import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> wrongCodeNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(KWidgetkeys.screen.passwordReset.confirmButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.passwordReset.confirmButton,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.passwordReset.confirmButton));

  await tester.pumpAndSettle();

  verify(
    () => mockGoRouter.goNamed(KRoute.pwResetEmail.name),
  ).called(1);
}