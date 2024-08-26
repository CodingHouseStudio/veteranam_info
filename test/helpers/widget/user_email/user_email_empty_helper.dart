import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> userEmailEmptyHelper(
  WidgetTester tester,
) async {
  await userEmailHelper(tester: tester);

  await userEmailSaveHelper(tester: tester, email: KTestText.fieldEmpty);

  expect(find.byKey(KWidgetkeys.widget.userEmailDialog.field), findsOneWidget);
}
