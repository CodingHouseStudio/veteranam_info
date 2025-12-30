import 'package:flutter/foundation.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';

Future<void> reportDialogOpenHelper({
  required WidgetTester tester,
  required Key? popupMenuKey,
}) async {
  if (popupMenuKey != null && find.byKey(popupMenuKey).evaluate().isNotEmpty) {
    await scrollingHelper(
      tester: tester,
      itemKey: popupMenuKey,
      offset: KTestConstants.scrollingDown,
    );

    await tester.tap(
      find.byKey(popupMenuKey).first,
      warnIfMissed: false,
    );

    await tester.pumpAndSettle();

    expect(find.byKey(ReportDialogKeys.button), findsOneWidget);
  } else {
    await scrollingHelper(
      tester: tester,
      offset: KTestConstants.scrollingDown,
      // scrollPositionAlignmentPolicy:
      //     ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
    );
  }

  await tester.tap(
    find.byKey(ReportDialogKeys.button).last,
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  await reportDialogHelper(tester);
}
