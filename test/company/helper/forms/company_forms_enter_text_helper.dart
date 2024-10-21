import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

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
    itemKey: KWidgetkeys.screen.company.photo,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.company.photo));

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.company.companyNameField,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.screen.company.companyNameField),
    companyName,
  );

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.company.publicNameField,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.screen.company.publicNameField),
    publicName,
  );

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.company.companyCodeField,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.screen.company.companyCodeField),
    companyCode,
  );

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.company.linkField,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.company.linkField,
  );

  if (link != null) {
    await tester.enterText(
      find.byKey(KWidgetkeys.screen.company.linkField),
      link,
    );

    await tester.pumpAndSettle();
  }
}
