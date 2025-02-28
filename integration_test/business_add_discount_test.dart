import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:veteranam/shared/constants/constants_flutter.dart';

import './test_dependency.dart';

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

    expect(find.byKey(MyDiscountsKeys.iconAdd), findsOneWidget);

    await tester.tap(find.byKey(MyDiscountsKeys.iconAdd));

    await tester.pumpAndSettle();

    expect(find.byKey(DiscountsAddKeys.screen), findsOneWidget);

    expect(find.byKey(DiscountsAddKeys.titleField), findsOneWidget);

    await scrollingHelperInt(
      tester: tester,
      itemKey: DiscountsAddKeys.titleField,
    );

    await tester.enterText(
      find.byKey(DiscountsAddKeys.titleField),
      KMockText.discountModel.title.uk,
    );

    await tester.pumpAndSettle();

    expect(find.byKey(DiscountsAddKeys.discountsField), findsOneWidget);

    await scrollingHelperInt(
      tester: tester,
      itemKey: DiscountsAddKeys.discountsField,
    );

    await tester.tap(
      find.byKey(DiscountsAddKeys.discountsField),
    );

    await tester.pumpAndSettle();

    expect(find.byKey(DropListFieldKeys.item), findsWidgets);

    await tester.tap(
      find.byKey(DropListFieldKeys.item).first,
    );

    await tester.pumpAndSettle();

    expect(find.byKey(DropListFieldKeys.item), findsNothing);

    await tester.enterText(
      find.byKey(DiscountsAddKeys.discountsField),
      KMockText.discountModel.discount.first.toString(),
    );

    await tester.pumpAndSettle();

    await tester.tapAt(Offset.zero);

    await tester.pumpAndSettle();

    expect(find.byKey(DiscountsAddKeys.eligibilityField), findsOneWidget);

    await scrollingHelperInt(
      tester: tester,
      itemKey: DiscountsAddKeys.eligibilityField,
    );

    await tester.tap(
      find.byKey(DiscountsAddKeys.eligibilityField),
    );

    await tester.pumpAndSettle();

    expect(find.byKey(DropListFieldKeys.item), findsWidgets);

    await tester.tap(
      find.byKey(DropListFieldKeys.item).first,
    );

    await tester.pumpAndSettle();

    expect(find.byKey(DropListFieldKeys.item), findsNothing);

    expect(find.byKey(DiscountsAddKeys.linkField), findsOneWidget);

    await scrollingHelperInt(
      tester: tester,
      itemKey: DiscountsAddKeys.linkField,
    );

    await tester.enterText(
      find.byKey(DiscountsAddKeys.linkField),
      KMockText.discountModel.directLink!,
    );

    await tester.pumpAndSettle();

    await scrollingHelperInt(
      tester: tester,
      itemKey: DiscountsAddKeys.sendButton,
    );

    expect(find.byKey(DiscountsAddKeys.sendButton), findsOneWidget);

    await tester.tap(
      find.byKey(DiscountsAddKeys.sendButton),
    );

    await tester.pumpAndSettle();

    await scrollingHelperInt(
      tester: tester,
      offset: KTestConstants.scrollingUp,
    );

    expect(find.byKey(DiscountsAddKeys.categoryField), findsOneWidget);

    await scrollingHelperInt(
      tester: tester,
      itemKey: DiscountsAddKeys.categoryField,
    );

    await tester.enterText(
      find.byKey(DiscountsAddKeys.categoryField),
      KMockText.discountModel.category.first.uk,
    );

    await tester.pumpAndSettle();

    await tester.tapAt(Offset.zero);

    await tester.pumpAndSettle();

    expect(find.byKey(DiscountsAddKeys.cityField), findsOneWidget);

    expect(find.byKey(DiscountsAddKeys.onlineSwitcher), findsOneWidget);

    await scrollingHelperInt(
      tester: tester,
      itemKey: DiscountsAddKeys.onlineSwitcher,
    );

    await tester.tap(find.byKey(DiscountsAddKeys.onlineSwitcher));

    await tester.pumpAndSettle();

    await tester.tap(
      find.byKey(DiscountsAddKeys.sendButton),
    );

    await tester.pumpAndSettle();

    await scrollingHelperInt(
      tester: tester,
      offset: KTestConstants.scrollingUp,
    );

    expect(find.byKey(DiscountsAddKeys.descriptionField), findsOneWidget);

    await scrollingHelperInt(
      tester: tester,
      itemKey: DiscountsAddKeys.descriptionField,
    );

    await tester.enterText(
      find.byKey(DiscountsAddKeys.descriptionField),
      KMockText.discountModel.description.uk,
    );

    await tester.pumpAndSettle();

    expect(find.byKey(DiscountsAddKeys.requirementsField), findsOneWidget);

    await scrollingHelperInt(
      tester: tester,
      itemKey: DiscountsAddKeys.requirementsField,
    );

    await tester.enterText(
      find.byKey(DiscountsAddKeys.requirementsField),
      KMockText.discountModel.requirements!.uk,
    );

    await tester.pumpAndSettle();

    await tester.tap(
      find.byKey(DiscountsAddKeys.sendButton),
    );

    await tester.pumpAndSettle();

    expect(find.byKey(ConfirmPublishDiscountKeys.dialog), findsOneWidget);

    expect(
      find.byKey(ConfirmPublishDiscountKeys.termsAndConditionsSwitcher),
      findsOneWidget,
    );

    await tester.tap(
      find.byKey(ConfirmPublishDiscountKeys.termsAndConditionsSwitcher),
    );

    await tester.pumpAndSettle();

    await tester.pumpAndSettle(const Duration(seconds: 5));
  });
}
