import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:veteranam/shared/constants/config.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import 'constants.dart';
import 'helpers/helpers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // This is run before all tests
  setUpAll(setUpGlobalIntegration);

  tearDownAll(tearDownGlobalIntegration);

  testWidgets('Sign Up Integration Test', (tester) async {
    await tester.pumpApp(tester);

    if (Config.isWeb) {
      expect(find.byKey(HomeKeys.screen), findsOneWidget);

      expect(find.byKey(NawbarKeys.loginButton), findsOneWidget);

      await tester.tap(find.byKey(NawbarKeys.loginButton));

      await tester.pumpAndSettle();

      expect(find.byKey(UserRoleKeys.screen), findsOneWidget);

      expect(find.byKey(UserRoleKeys.signUpUserButton), findsOneWidget);

      await scrollingHelperInt(
        tester: tester,
        itemKey: UserRoleKeys.signUpUserButton,
      );

      await tester.tap(find.byKey(UserRoleKeys.signUpUserButton));

      await tester.pumpAndSettle();
    } else {
      expect(find.byKey(DiscountsKeys.screen), findsOneWidget);

      expect(find.byKey(MobNavigationKeys.login), findsOneWidget);

      await tester.tap(find.byKey(MobNavigationKeys.login));

      await tester.pumpAndSettle();

      expect(find.byKey(LoginKeys.screen), findsOneWidget);

      expect(find.byKey(LoginKeys.signUpButton), findsOneWidget);

      await tester.tap(find.byKey(LoginKeys.signUpButton));

      await tester.pumpAndSettle();
    }

    expect(find.byKey(SignUpKeys.screen), findsOneWidget);

    expect(find.byKey(EmailPasswordFieldsKeys.fieldEmail), findsWidgets);

    await tester.enterText(
      find.byKey(EmailPasswordFieldsKeys.fieldEmail),
      KTestVariables.signUpEmail,
    );

    await tester.pumpAndSettle();

    await scrollingHelperInt(tester: tester, itemKey: SignUpKeys.button);

    await tester.tap(find.byKey(SignUpKeys.button));

    await tester.pumpAndSettle();

    expect(find.byKey(EmailPasswordFieldsKeys.fieldPassword), findsWidgets);

    await tester.enterText(
      find.byKey(EmailPasswordFieldsKeys.fieldPassword),
      KTestVariables.signInUpPassword,
    );

    await tester.pumpAndSettle();

    await scrollingHelperInt(tester: tester, itemKey: SignUpKeys.button);

    await tester.tap(find.byKey(SignUpKeys.button));

    var count = 0;

    while (Config.isWeb
        ? find.byKey(SignUpKeys.screen).evaluate().isNotEmpty
        : find.byKey(MobAuthenticationDialogKeys.dialog).evaluate().isEmpty &&
            count < 20) {
      count++;
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
    }

    await tester.pumpAndSettle();

    if (Config.isWeb) {
      expect(find.byKey(SignUpKeys.screen), findsNothing);

      expect(find.byKey(HomeKeys.screen), findsOneWidget);
    } else {
      expect(find.byKey(MobAuthenticationDialogKeys.dialog), findsOneWidget);

      expect(find.byKey(MobAuthenticationDialogKeys.button), findsOneWidget);

      await tester.tap(find.byKey(MobAuthenticationDialogKeys.button));

      await tester.pumpAndSettle();

      expect(find.byKey(MobAuthenticationDialogKeys.dialog), findsNothing);

      expect(find.byKey(DiscountsKeys.screen), findsOneWidget);
    }
  });
}
