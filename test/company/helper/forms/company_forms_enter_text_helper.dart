import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';

Future<void> companyFormsEnterTextHelper({
  required WidgetTester tester,
  required String companyName,
  required String publicName,
  required String companyCode,
  required String? link,
}) async {
  await scrollingHelper(
    tester: tester,
    itemKey: CompanyKeys.photo,
  );

  await tester.tap(find.byKey(CompanyKeys.photo));

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    itemKey: CompanyKeys.companyNameField,
  );

  await tester.enterText(
    find.byKey(CompanyKeys.companyNameField),
    companyName,
  );

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    itemKey: CompanyKeys.publicNameField,
  );

  await tester.enterText(
    find.byKey(CompanyKeys.publicNameField),
    publicName,
  );

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    itemKey: CompanyKeys.companyCodeField,
  );

  await tester.enterText(
    find.byKey(CompanyKeys.companyCodeField),
    companyCode,
  );

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    itemKey: CompanyKeys.linkField,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: CompanyKeys.linkField,
  );

  if (link != null) {
    await tester.enterText(
      find.byKey(CompanyKeys.linkField),
      link,
    );

    await tester.pumpAndSettle();
  }
}
