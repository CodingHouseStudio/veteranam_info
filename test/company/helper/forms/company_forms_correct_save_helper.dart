import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> companyFormsCorrectSaveHelper(
  WidgetTester tester,
) async {
  await companyFormsEnterTextHelper(
    tester: tester,
    companyCode: KTestVariables.fullCompanyModel.code!,
    publicName: KTestVariables.fullCompanyModel.publicName!,
    companyName: KTestVariables.fullCompanyModel.companyName!,
    link: KTestVariables.fullCompanyModel.link,
  );

  await tester.tap(find.byKey(CompanyKeys.saveButton));

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    itemKey: CompanyKeys.saveButton,
  );

  expect(
    find.byKey(CompanyKeys.submitingText),
    findsOneWidget,
  );

  // expect(find.text('Your data has been successfully updated!'),
  // findsOneWidget);
}
