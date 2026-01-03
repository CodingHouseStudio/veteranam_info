import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> hidePasswordHelper(
  WidgetTester tester,
) async {
  await emailPasswordFieldsEmHelper(
    tester: tester,
    email: KTestVariables.userEmail,
  );

  await tester.tap(find.byKey(LoginKeys.button));

  await tester.pumpAndSettle();

  await emailPasswordFieldsHelper(tester: tester, showPassword: true);

  await emailPasswordFieldsHidePasHelper(tester);

  await emailPasswordFieldsHelper(tester: tester, showPassword: false);
}
