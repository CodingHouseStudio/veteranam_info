import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> investorsFailureHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    itemKey: InvestorsKeys.feedbackTitle,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: InvestorsKeys.leftImages,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: InvestorsKeys.fundsTitle,
  );

  await loadingFailureHelper(
    tester: tester,
    card: InformationKeys.card,
    buttonMock: null,
  );
}
