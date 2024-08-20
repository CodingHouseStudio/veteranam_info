import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> mobFaqFailureHelper(
  WidgetTester tester,
) async {
  await loadingFailureHelper(
    tester: tester,
    card: KWidgetkeys.screen.mobFaq.list,
    buttonMock: KWidgetkeys.screen.mobFaq.buttonMock,
  );
}
