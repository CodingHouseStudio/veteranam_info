import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../helper.dart';

Future<void> profileFormsIncorrectSaveHelper({
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
}
