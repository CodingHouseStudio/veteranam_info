import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> userEmailHelper({
  required WidgetTester tester,
  bool hover = true,
}) async {
  // await changeWindowSizeHelper(
  //   tester: tester,
  //   test: () async {
  expect(
    find.byKey(KWidgetkeys.widget.userEmailDialog.icon),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.userEmailDialog.emailDialogTitle),
    findsOneWidget,
  );
  expect(
    find.byKey(KWidgetkeys.widget.userEmailDialog.emailDialogSubtitle),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.userEmailDialog.field),
    findsOneWidget,
  );

  if (hover) {
    await hoverHelper(
      tester: tester,
      key: KWidgetkeys.widget.userEmailDialog.field,
    );
  }

  expect(
    find.byKey(KWidgetkeys.widget.userEmailDialog.button),
    findsOneWidget,
  );
  //   },
  // );
}
