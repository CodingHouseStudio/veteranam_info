import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> profileFormsCorrectSaveHelper({
  required WidgetTester tester,
}) async {
  await profileFormsEnterTextHelper(
    tester: tester,
    name: KTestVariables.nameCorrect,
    surname: KTestVariables.surnameCorrect,
    nickname: KTestVariables.nicknameCorrect,
  );

  await tester.tap(find.byKey(ProfileKeys.saveButton));

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    itemKey: ProfileKeys.saveButton,
  );

  expect(
    find.byKey(ProfileKeys.submitingText),
    findsOneWidget,
  );

  // expect(find.text('Your data has been successfully updated!'),
  // findsOneWidget);
}
