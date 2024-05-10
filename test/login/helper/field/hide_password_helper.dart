import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../../text_dependency.dart';

Future<void> hidePasswordHelper(
  WidgetTester tester,
) async {
  await emailPasswordFieldsEmHelper(
    tester: tester,
    email: KTestText.userEmail,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.login.button));

  await tester.pumpAndSettle();

  await emailPasswordFieldsHelper(tester: tester, showPassword: true);

  await emailPasswordFieldsHidePasHelper(tester);

  await emailPasswordFieldsHelper(tester: tester, showPassword: false);
}
