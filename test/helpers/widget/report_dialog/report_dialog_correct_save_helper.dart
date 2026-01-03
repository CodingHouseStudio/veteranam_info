import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> reportDialogCorrectSaveHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
  required Key? popupMenuKey,
}) async {
  await changeWindowSizeHelper(
    tester: tester,
    test: () async {
      await reportDialogOpenHelper(
        tester: tester,
        popupMenuKey: popupMenuKey,
      );

      expect(
        find.byKey(ReportDialogKeys.cancel),
        findsOneWidget,
      );

      await tester.tap(find.byKey(ReportDialogKeys.cancel));

      await tester.pumpAndSettle();

      verify(() => mockGoRouter.pop()).called(1);

      // expect(
      //   find.byKey(ReportDialogKeys.cancel),
      //   findsNothing,
      // );
      // await reportDialogOpenHelper(tester);

      await reportDialogEnterTextHelper(
        tester: tester,
        // email: KTestVariables.userEmail,
        message: KTestVariables.reportItems.first.message,
      );

      await reportDialogHelper(tester, openedDialog: false);
    },
  );
}
