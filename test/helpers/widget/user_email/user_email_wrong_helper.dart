import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_dependency.dart';

Future<void> userEmailWrongHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await userEmailHelper(tester);

  await userEmailSaveHelper(tester: tester, email: KTestText.field);

  verify(
    () => mockGoRouter.pop(),
  ).called(1);
}