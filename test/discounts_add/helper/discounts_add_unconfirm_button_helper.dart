import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:veteranam/shared/shared.dart';

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
      if (icon) {
        await dialogCancelIconHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
        );
      } else {
        expect(
          find.byKey(KWidgetkeys.widget.dialogs.confirmButton),
          findsOneWidget,
        );

        await tester.tap(find.byKey(KWidgetkeys.widget.dialogs.confirmButton));

        await tester.pumpAndSettle();

        verify(() => mockGoRouter.goNamed(KRoute.myDiscounts.name)).called(1);
      }
    },
  );
}