import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/text/url_parameters.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';

Future<void> emailPasswordFieldsNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(EmailPasswordFieldsKeys.recoveryButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: EmailPasswordFieldsKeys.recoveryButton,
  );

  await tester.tap(find.byKey(EmailPasswordFieldsKeys.recoveryButton));

  await tester.pumpAndSettle();

  verify(
    () => mockGoRouter.goNamed(
      KRoute.forgotPassword.name,
      queryParameters: {UrlParameters.email: KTestVariables.userEmail},
    ),
  ).called(1);
}
