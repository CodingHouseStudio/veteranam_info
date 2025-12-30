import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> passwordFailureHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await passwordEnterHelper(
    tester: tester,
    password: KTestVariables.passwordCorrect,
    confirmPassword: KTestVariables.passwordCorrect,
  );

  expect(
    find.byKey(PasswordResetKeys.submitingText),
    findsOneWidget,
  );

  verifyNever(
    () => mockGoRouter.goNamed(KRoute.login.name),
  );
}
