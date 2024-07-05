import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> homeFailureHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp1000,
  );

  await loadingFailureHelper(
    tester: tester,
    card: KWidgetkeys.screen.home.faq,
    buttonMock: KWidgetkeys.screen.home.buttonMock,
  );
}
