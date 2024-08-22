import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> userEmailCorrectHelper(
  WidgetTester tester,
) async {
  await userEmailHelper(tester);

  await userEmailSaveHelper(
    tester: tester,
    email: KTestText.emailModel.email,
  );

  expect(find.byKey(KWidgetkeys.widget.userEmailDialog.field), findsNothing);
}
