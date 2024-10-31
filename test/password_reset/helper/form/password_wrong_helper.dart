import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/route_constants.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> passwordWrongHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await passwordEnterHelper(
    tester: tester,
    password: KTestText.passwordIncorrect,
    confirmPassword: KTestText.passwordIncorrectNumber,
  );

  verifyNever(
    () => mockGoRouter.goNamed(KRoute.login.name),
  );

  await passwordEnterHelper(
    tester: tester,
    password: KTestText.passwordIncorrect,
    confirmPassword: KTestText.passwordIncorrect,
  );

  verifyNever(
    () => mockGoRouter.goNamed(KRoute.login.name),
  );
}
