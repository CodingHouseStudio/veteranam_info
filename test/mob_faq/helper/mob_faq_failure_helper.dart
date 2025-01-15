import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> mobFaqFailureHelper(
  WidgetTester tester,
) async {
  await loadingFailureHelper(
    tester: tester,
    card: MobFaqKeys.list,
    buttonMock: MobFaqKeys.buttonMock,
  );
}
