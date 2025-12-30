import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> discountsAddDescriptionEnterHelper({
  required WidgetTester tester,
  required String descriptionText,
  required String requirmentsText,
  required String emailText,
  bool isEdit = false,
}) async {
  expect(
    find.byKey(DiscountsAddKeys.descriptionField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: DiscountsAddKeys.descriptionField,
  );

  await tester.enterText(
    find.byKey(DiscountsAddKeys.descriptionField),
    descriptionText,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(DiscountsAddKeys.requirementsField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: DiscountsAddKeys.requirementsField,
  );

  await tester.enterText(
    find.byKey(DiscountsAddKeys.requirementsField),
    requirmentsText,
  );

  await tester.pumpAndSettle();

  if (!isEdit) {
    expect(
      find.byKey(DiscountsAddKeys.emailField),
      findsOneWidget,
    );

    await scrollingHelper(
      tester: tester,
      itemKey: DiscountsAddKeys.emailField,
    );

    await tester.enterText(
      find.byKey(DiscountsAddKeys.emailField),
      emailText,
    );

    await tester.pumpAndSettle();
  } else {
    expect(
      find.byKey(DiscountsAddKeys.emailField),
      findsNothing,
    );
  }

  await discountsAddSendHelper(tester);
}
