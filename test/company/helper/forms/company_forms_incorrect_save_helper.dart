import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> companyFormsIncorrectSaveHelper(
  WidgetTester tester,
) async {
  await companyFormsEnterTextHelper(
    tester: tester,
    companyCode: KTestText.companyWrongCode,
    publicName: KTestText.fieldEmpty,
    companyName: KTestText.companyWrongName,
    link: KTestText.field,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.company.saveButton));

  await tester.pumpAndSettle();
}
