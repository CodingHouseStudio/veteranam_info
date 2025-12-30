import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';
import '../../test_dependency.dart';

Future<void> sendUserRoleHelper({
  required WidgetTester tester,
  required UserRepository mockUserRepository,
}) async {
  await chekPointHelper(
    tester: tester,
    twiceTap: false,
    isEmpty: false,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: QuestionsFormKeys.button,
  );

  await tester.tap(find.byKey(QuestionsFormKeys.button));

  await tester.pumpAndSettle();

  verify(
    mockUserRepository.updateUserSetting(
      userSetting: UserSetting.empty.copyWith(
        userRole: UserRole.veteran,
      ),
    ),
  ).called(1);
}
