import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> companyFormsCorrectSaveHelper(
  WidgetTester tester,
) async {
  await companyFormsEnterTextHelper(
    tester: tester,
    companyCode: KTestText.fullCompanyModel.code!,
    publicName: KTestText.fullCompanyModel.publicName!,
    companyName: KTestText.fullCompanyModel.companyName!,
    link: KTestText.fullCompanyModel.link,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.company.saveButton));

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.company.saveButton,
  );

  expect(
    find.byKey(KWidgetkeys.screen.company.submitingText),
    findsOneWidget,
  );

  // expect(find.text('Your data has been successfully updated!'),
  // findsOneWidget);
}
