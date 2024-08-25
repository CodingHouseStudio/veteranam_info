import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> reportDialogCheckFailureHelper(
  WidgetTester tester,
) async {
  await reportDialogOpenHelper(tester);

  await changeWindowSizeHelper(
    tester: tester,
    size: KTestConstants.windowSmallSize,
    test: () async {
      expect(
        find.byKey(KWidgetkeys.widget.reportDialog.checkPointError),
        findsNothing,
      );

      expect(
        find.byKey(KWidgetkeys.widget.reportDialog.checkPoint),
        findsWidgets,
      );

      expect(find.byKey(KWidgetkeys.widget.checkPoint.icon), findsNothing);

      expect(
        find.byKey(KWidgetkeys.widget.reportDialog.sendButton),
        findsOneWidget,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.widget.reportDialog.sendButton,
      );

      await tester.tap(find.byKey(KWidgetkeys.widget.reportDialog.sendButton));

      await tester.pumpAndSettle();

      expect(
        find.byKey(KWidgetkeys.widget.reportDialog.checkPointError),
        findsOneWidget,
      );
    },
  );
}
