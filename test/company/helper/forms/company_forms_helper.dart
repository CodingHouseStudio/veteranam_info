import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';

Future<void> companyFormsHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(CompanyKeys.editText),
    findsOneWidget,
  );

  expect(
    find.byKey(CompanyKeys.photo),
    findsOneWidget,
  );

  expect(
    find.byKey(CompanyKeys.companyNameField),
    findsOneWidget,
  );

  expect(
    find.byKey(CompanyKeys.publicNameField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: CompanyKeys.companyCodeField,
  );

  expect(
    find.byKey(CompanyKeys.userEmailField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: CompanyKeys.linkField,
  );

  expect(
    find.byKey(CompanyKeys.saveButton),
    findsOneWidget,
  );
}
