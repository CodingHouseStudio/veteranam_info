import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../../text_dependency.dart';
import '../helper.dart';

Future<void> wrongSubmitedHelper(
  WidgetTester tester,
) async {
  await loginFieldsHelper(
    tester: tester,
    password: KTestText.passwordWrong,
    email: KTestText.useremailWrong,
    dataIsCorrect: true,
  );

  expect(
    find.byKey(KWidgetkeys.screen.login.failureMessage),
    findsOneWidget,
  );
}
