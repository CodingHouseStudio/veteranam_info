import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> emailPasswordFieldsNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(KWidgetkeys.widget.emailPasswordFields.recoveryButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.emailPasswordFields.recoveryButton,
  );

  await tester
      .tap(find.byKey(KWidgetkeys.widget.emailPasswordFields.recoveryButton));

  await tester.pumpAndSettle();

  verify(
    () => mockGoRouter.goNamed(
      KRoute.pwResetEmail.name,
      queryParameters: {UrlParameters.email: KTestText.userEmail},
    ),
  ).called(1);
}