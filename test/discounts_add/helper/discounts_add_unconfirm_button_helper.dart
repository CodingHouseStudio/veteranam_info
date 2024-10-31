import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/route_constants.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';
import 'helper.dart';

Future<void> discountsAddUnconfirmButtonlHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
  required bool icon,
  bool deskOpen = false,
}) async {
  if (deskOpen) {
    await changeWindowSizeHelper(
      tester: tester,
      test: () async => discountsAddDialogHelper(tester),
    );
  } else {
    await discountsAddDialogHelper(tester);
  }

  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      if (find
          .byKey(KWidgetkeys.widget.confirmDialog.title)
          .evaluate()
          .isEmpty) {
        await discountsAddDialogHelper(tester);
      }

      if (icon) {
        await dialogCancelIconHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
        );
      } else {
        expect(
          find.byKey(KWidgetkeys.widget.confirmDialog.confirmButton),
          findsOneWidget,
        );

        await tester
            .tap(find.byKey(KWidgetkeys.widget.confirmDialog.confirmButton));

        await tester.pumpAndSettle();

        verify(() => mockGoRouter.goNamed(KRoute.myDiscounts.name)).called(1);
      }
    },
  );
}
