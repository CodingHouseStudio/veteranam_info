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
        // email: KTestText.userEmail,
        message: KTestVariables.reportItems.first.message,
      );

      verify(() => mockGoRouter.pop()).called(1);
    },
  );
}
