import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> mobFaqMockButtonHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp1000,
    itemKey: MobFaqKeys.buttonMock,
  );

  await mockButtonHelper(
    tester: tester,
    card: MobFaqKeys.list,
    buttonMock: MobFaqKeys.buttonMock,
  );
}
