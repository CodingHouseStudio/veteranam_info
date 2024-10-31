import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> investorsFailureHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.investors.feedbackTitle,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.investors.leftImages,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.investors.fundsTitle,
  );

  await loadingFailureHelper(
    tester: tester,
    card: KWidgetkeys.screen.information.card,
    buttonMock: KWidgetkeys.screen.investors.buttonMock,
  );
}
