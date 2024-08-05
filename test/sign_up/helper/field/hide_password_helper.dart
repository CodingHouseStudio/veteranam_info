import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> hidePasswordHelper(
  WidgetTester tester,
) async {
  await emailPasswordFieldsEmHelper(
    tester: tester,
    email: KTestText.userEmail,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.signUp.button));

  await tester.pumpAndSettle();

  await emailPasswordFieldsHelper(tester: tester, showPassword: true);

  await emailPasswordFieldsHidePasHelper(tester);

  await emailPasswordFieldsHelper(tester: tester, showPassword: false);
}
