import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/route_constants.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> passwordCorrectHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await passwordEnterHelper(
    tester: tester,
    password: KTestText.passwordCorrect,
    confirmPassword: KTestText.passwordCorrect,
  );

  verify(
    () => mockGoRouter.goNamed(KRoute.login.name),
  ).called(1);
}
