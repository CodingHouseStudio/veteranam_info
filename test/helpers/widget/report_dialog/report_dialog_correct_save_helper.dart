import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> reportDialogCorrectSaveHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await changeWindowSizeHelper(
    tester: tester,
    test: () async {
      await reportDialogOpenHelper(tester);

      expect(
        find.byKey(KWidgetkeys.widget.reportDialog.cancel),
        findsOneWidget,
      );

      await tester.tap(find.byKey(KWidgetkeys.widget.reportDialog.cancel));

      await tester.pumpAndSettle();

      verify(() => mockGoRouter.pop()).called(1);

      // expect(
      //   find.byKey(KWidgetkeys.widget.reportDialog.cancel),
      //   findsNothing,
      // );
      // await reportDialogOpenHelper(tester);

      await reportDialogEnterTextHelper(
        tester: tester,
        // email: KTestText.userEmail,
        message: KTestText.reportItems.first.message,
      );

      verify(() => mockGoRouter.pop()).called(1);
    },
  );
}
