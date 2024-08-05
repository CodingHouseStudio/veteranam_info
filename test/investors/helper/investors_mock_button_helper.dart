import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> investorsMockButtonHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(tester: tester, offset: KTestConstants.scrollingDown);

  await mockButtonHelper(
    tester: tester,
    card: KWidgetkeys.screen.information.card,
    buttonMock: KWidgetkeys.screen.investors.buttonMock,
  );
}
