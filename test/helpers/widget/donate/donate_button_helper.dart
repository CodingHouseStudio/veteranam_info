import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

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

  expect(find.byKey(KWidgetkeys.widget.donateButton.icon), findsWidgets);

  expect(find.byKey(KWidgetkeys.widget.donateButton.text), findsWidgets);

  expect(find.byKey(KWidgetkeys.widget.donateButton.rotateIcon), findsNothing);

  if (tap) {
    await scrollingHelper(
      tester: tester,
      itemKey: KWidgetkeys.widget.donateButton.text,
    );

    await tester.tap(
      find.byKey(KWidgetkeys.widget.donateButton.text).first,
      warnIfMissed: false,
    );
  }

  if (isDesk) {
    await hoverHelper(
      tester: tester,
      key: KWidgetkeys.widget.donateButton.text,
      hoverElement: KWidgetkeys.widget.donateButton.rotateIcon,
    );
  }
}
