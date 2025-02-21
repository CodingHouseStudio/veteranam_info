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

  testWidgets('Sign Up Integration Test', (tester) async {
    await tester.pumpApp(tester);

    expect(find.byKey(HomeKeys.screen), findsOneWidget);

    expect(find.byKey(NawbarKeys.loginButton), findsOneWidget);

    await tester.tap(find.byKey(NawbarKeys.loginButton));

    await tester.pumpAndSettle();

    expect(find.byKey(UserRoleKeys.screen), findsOneWidget);

    expect(find.byKey(UserRoleKeys.signUpUserButton), findsOneWidget);

    await tester.tap(find.byKey(UserRoleKeys.signUpUserButton));

    await tester.pumpAndSettle();

    expect(find.byKey(SignUpKeys.screen), findsOneWidget);

    expect(find.byKey(EmailPasswordFieldsKeys.fieldEmail), findsWidgets);

    await tester.enterText(
      find.byKey(EmailPasswordFieldsKeys.fieldEmail),
      KTestVariables.signUpEmail,
    );

    await tester.pumpAndSettle();

    await tester.tap(find.byKey(SignUpKeys.button));

    await tester.pumpAndSettle();

    expect(find.byKey(EmailPasswordFieldsKeys.fieldPassword), findsWidgets);

    await tester.enterText(
      find.byKey(EmailPasswordFieldsKeys.fieldPassword),
      KTestVariables.signInUpPassword,
    );

    await tester.pumpAndSettle();

    await tester.tap(find.byKey(SignUpKeys.button));

    var count = 0;
    do {
      count++;
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
    } while (find.byKey(SignUpKeys.screen).evaluate().isNotEmpty || count > 20);

    await tester.pumpAndSettle();

    expect(find.byKey(SignUpKeys.screen), findsNothing);

    expect(find.byKey(HomeKeys.screen), findsOneWidget);
  });
}
