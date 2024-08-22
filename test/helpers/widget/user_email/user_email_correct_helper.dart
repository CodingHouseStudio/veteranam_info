import 'package:flutter_test/flutter_test.dart';

import '../../../test_dependency.dart';

Future<void> userEmailCorrectHelper(
  WidgetTester tester,
) async {
  await userEmailSaveHelper(
    tester: tester,
    email: KTestText.emailModel.email,
  );

  expect(find.text(KTestText.emailModel.email), findsNothing);
}
