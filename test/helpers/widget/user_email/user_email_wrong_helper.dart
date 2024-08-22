import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> userEmailWrongHelper(
  WidgetTester tester,
) async {
  await userEmailHelper(tester);

  await userEmailSaveHelper(tester: tester, email: KTestText.field);

  expect(find.byKey(KWidgetkeys.widget.userEmailDialog.field), findsNothing);
}
