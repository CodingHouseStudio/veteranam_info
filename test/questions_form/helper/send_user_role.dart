import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../../text_dependency.dart';

Future<void> sendUserRoleHelper({
  required WidgetTester tester,
  required AuthenticationRepository mockAuthenticationRepository,
}) async {
  await chekPointHelper(tester: tester);

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.questionsForm.button,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.questionsForm.button));

  await tester.pumpAndSettle();

  verify(
    mockAuthenticationRepository.updateUserSetting(
      userSetting: UserSetting.empty.copyWith(
        userRole: UserRole.veteran,
      ),
    ),
  ).called(1);
}
