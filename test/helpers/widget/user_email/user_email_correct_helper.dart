import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_dependency.dart';

Future<void> userEmailCorrectHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await userEmailHelper(tester: tester);

  await userEmailSaveHelper(
    tester: tester,
    email: KTestText.emailModel.email,
  );

  verify(
    () => mockGoRouter.pop(),
  ).called(1);
}
