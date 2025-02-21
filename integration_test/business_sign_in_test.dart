import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import 'constants.dart';
import 'helpers/helpers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // This is run before all tests
  setUpAll(setUpGlobalIntegration);

  tearDownAll(tearDownGlobalItegration);

  testWidgets('Business Sign In Integration Test', (tester) async {
    await tester.pumpApp(tester);

    expect(find.byKey(LoginKeys.screen), findsOneWidget);

    expect(find.byKey(EmailPasswordFieldsKeys.fieldEmail), findsWidgets);

    await tester.enterText(
      find.byKey(EmailPasswordFieldsKeys.fieldEmail),
      KTestVariables.sgignInEmail,
    );

    await tester.pumpAndSettle();

    await tester.tap(find.byKey(LoginKeys.button));

    await tester.pumpAndSettle();

    expect(find.byKey(EmailPasswordFieldsKeys.fieldPassword), findsWidgets);

    await tester.enterText(
      find.byKey(EmailPasswordFieldsKeys.fieldPassword),
      KTestVariables.signInUpPassword,
    );

    await tester.pumpAndSettle();

    await tester.tap(find.byKey(LoginKeys.button));

    var count = 0;
    do {
      count++;
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
    } while (find.byKey(LoginKeys.screen).evaluate().isNotEmpty || count > 20);

    await tester.pumpAndSettle();

    expect(find.byKey(LoginKeys.screen), findsNothing);

    expect(find.byKey(MyDiscountsKeys.screen), findsOneWidget);
  });
}
