import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> profileFormsIncorrectSaveHelper({
  required WidgetTester tester,
}) async {
  await profileFormsEnterTextHelper(
    tester: tester,
    name: KTestVariables.fieldEmpty,
    surname: KTestVariables.fieldEmpty,
    nickname: KTestVariables.fieldEmpty,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.profile.saveButton));

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.screen.profile.submitingText),
    findsNothing,
  );
}
