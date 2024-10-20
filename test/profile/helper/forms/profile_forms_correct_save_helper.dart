import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> profileFormsCorrectSaveHelper({
  required WidgetTester tester,
  required String name,
  required String surname,
  required String nickname,
}) async {
  await profileFormsEnterTextHelper(
    tester: tester,
    name: name,
    surname: surname,
    nickname: nickname,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.profile.saveButton));

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.profile.saveButton,
  );

  expect(
    find.byKey(KWidgetkeys.screen.profile.submitingText),
    findsOneWidget,
  );

  // expect(find.text('Your data has been successfully updated!'),
  // findsOneWidget);
}
