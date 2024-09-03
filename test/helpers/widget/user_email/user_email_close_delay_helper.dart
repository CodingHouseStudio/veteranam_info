import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> userEmailCloseDelayHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await changeWindowSizeHelper(
    tester: tester,
    size: KTestConstants.windowMobileSize,
    test: () async {
      await userEmailHelper(tester: tester, hover: false);

      expect(
        find.byKey(KWidgetkeys.widget.userEmailDialog.icon),
        findsOneWidget,
      );

      await tester.tap(find.byKey(KWidgetkeys.widget.userEmailDialog.icon));

      await tester.pump();

      verifyNever(
        () => mockGoRouter.pop(),
      );

      await tester.pumpAndSettle(
        const Duration(seconds: KDimensions.emailCloseDelay * 2),
      );

      await tester.tap(find.byKey(KWidgetkeys.widget.userEmailDialog.icon));

      await tester.pumpAndSettle();

      verify(
        () => mockGoRouter.pop<bool>(false),
      ).called(1);
    },
  );
}
