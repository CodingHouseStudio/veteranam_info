import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> companyFormsHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.company.editText),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.company.photo),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.company.companyNameField),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.company.publicNameField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.company.companyCodeField,
  );

  expect(
    find.byKey(KWidgetkeys.screen.company.userEmailField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.company.linkField,
  );

  expect(
    find.byKey(KWidgetkeys.screen.company.saveButton),
    findsOneWidget,
  );
}
