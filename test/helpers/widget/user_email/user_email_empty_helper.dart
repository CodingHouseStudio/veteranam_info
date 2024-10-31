import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> userEmailEmptyHelper(
  WidgetTester tester,
) async {
  await userEmailHelper(tester: tester);

  await userEmailSaveHelper(tester: tester, email: KTestText.fieldEmpty);

  expect(find.byKey(KWidgetkeys.widget.userEmailDialog.field), findsOneWidget);
}
