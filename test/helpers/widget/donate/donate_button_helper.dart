import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> donateButtonHelper({
  required WidgetTester tester,
  required bool tap,
  required bool isDesk,
  bool scrollDown = false,
}) async {
  if (scrollDown) {
    await scrollingHelper(tester: tester, offset: KTestConstants.scrollingDown);
  }

  expect(find.byKey(DonateButtonKeys.icon), findsWidgets);

  expect(find.byKey(DonateButtonKeys.text), findsWidgets);

  expect(find.byKey(DonateButtonKeys.rotateIcon), findsNothing);

  if (tap) {
    await scrollingHelper(
      tester: tester,
      itemKey: DonateButtonKeys.text,
    );

    await tester.tap(
      find.byKey(DonateButtonKeys.text).first,
      warnIfMissed: false,
    );
  }

  if (isDesk) {
    await hoverHelper(
      tester: tester,
      key: DonateButtonKeys.text,
      hoverElement: DonateButtonKeys.rotateIcon,
    );
  }
}
