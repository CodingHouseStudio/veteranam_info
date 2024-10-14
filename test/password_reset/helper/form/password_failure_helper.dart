import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> passwordFailureHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await passwordEnterHelper(
    tester: tester,
    password: KTestText.passwordCorrect,
    confirmPassword: KTestText.passwordCorrect,
  );

  expect(
    find.byKey(KWidgetkeys.screen.passwordReset.submitingText),
    findsOneWidget,
  );

  verifyNever(
    () => mockGoRouter.goNamed(KRoute.login.name),
  );
}
