import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import 'constants.dart';
import 'helpers/helpers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // This is run before all tests
  setUpAll(setUpGlobalIntegration);

  tearDownAll(tearDownGlobalIntegration);

  testWidgets('Sign up', (tester) async {
    await tester.pumpApp(tester);

    expect(find.byKey(LoginKeys.screen), findsOneWidget);

    expect(find.byKey(LoginKeys.signUpButton), findsOneWidget);

    await tester.tap(find.byKey(LoginKeys.signUpButton));

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
    while (find.byKey(SignUpKeys.screen).evaluate().isNotEmpty && count < 20) {
      count++;
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
    }

    await tester.pumpAndSettle();

    expect(find.byKey(SignUpKeys.screen), findsNothing);

    expect(find.byKey(MyDiscountsKeys.screen), findsOneWidget);

    expect(find.byKey(MyDiscountsKeys.buttonProfile), findsOneWidget);

    await tester.tap(find.byKey(MyDiscountsKeys.buttonProfile));

    await tester.pumpAndSettle();

    expect(find.byKey(CompanyKeys.screen), findsOneWidget);

    expect(find.byKey(CompanyKeys.publicNameField), findsOneWidget);

    await scrollingHelperInt(
      tester: tester,
      itemKey: CompanyKeys.publicNameField,
    );

    await tester.enterText(
      find.byKey(CompanyKeys.publicNameField),
      KTestVariables.field,
    );

    await tester.pumpAndSettle();

    expect(find.byKey(CompanyKeys.companyNameField), findsOneWidget);

    await scrollingHelperInt(
      tester: tester,
      itemKey: CompanyKeys.companyNameField,
    );

    await tester.enterText(
      find.byKey(CompanyKeys.companyNameField),
      KTestVariables.field,
    );

    await tester.pumpAndSettle();

    expect(find.byKey(CompanyKeys.companyCodeField), findsOneWidget);

    await scrollingHelperInt(
      tester: tester,
      itemKey: CompanyKeys.companyCodeField,
    );

    await tester.enterText(
      find.byKey(CompanyKeys.companyCodeField),
      KTestVariables.companyCode,
    );

    await tester.pumpAndSettle();

    expect(find.byKey(CompanyKeys.saveButton), findsOneWidget);

    await scrollingHelperInt(
      tester: tester,
      itemKey: CompanyKeys.saveButton,
    );

    await tester.tap(find.byKey(CompanyKeys.saveButton));

    await tester.pumpAndSettle();

    await scrollingHelperInt(
      tester: tester,
      offset: KTestConstants.scrollingUp,
    );

    expect(find.byKey(NawbarKeys.myDiscountsButton), findsOneWidget);

    await tester.tap(find.byKey(NawbarKeys.myDiscountsButton));

    await tester.pumpAndSettle();

    expect(find.byKey(MyDiscountsKeys.screen), findsOneWidget);

    expect(find.byKey(MyDiscountsKeys.buttonProfile), findsNothing);

    expect(find.byKey(MyDiscountsKeys.iconAdd), findsOneWidget);

    expect(find.byKey(MyDiscountsKeys.buttonAdd), findsOneWidget);
  });
}
