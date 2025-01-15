import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> companyFormsIncorrectSaveHelper(
  WidgetTester tester,
) async {
  await companyFormsEnterTextHelper(
    tester: tester,
    companyCode: KTestVariables.companyWrongCode,
    publicName: KTestVariables.fieldEmpty,
    companyName: KTestVariables.companyWrongName,
    link: KTestVariables.field,
  );

  await tester.tap(find.byKey(CompanyKeys.saveButton));

  await tester.pumpAndSettle();
}
