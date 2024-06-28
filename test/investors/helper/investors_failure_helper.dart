import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

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
    itemKey: KWidgetkeys.screen.investors.fundsPoint,
  );

  await loadingFailureHelper(
    tester: tester,
    card: KWidgetkeys.screen.information.card,
    buttonMock: KWidgetkeys.screen.investors.buttonMock,
  );
}
