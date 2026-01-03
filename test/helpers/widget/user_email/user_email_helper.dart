import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> userEmailHelper({
  required WidgetTester tester,
  bool hover = true,
}) async {
  // await changeWindowSizeHelper(
  //   tester: tester,
  //   test: () async {
  expect(
    find.byKey(UserEmailDialogKeys.icon),
    findsOneWidget,
  );

  expect(
    find.byKey(UserEmailDialogKeys.emailDialogTitle),
    findsOneWidget,
  );
  expect(
    find.byKey(UserEmailDialogKeys.emailDialogSubtitle),
    findsOneWidget,
  );

  expect(
    find.byKey(UserEmailDialogKeys.field),
    findsOneWidget,
  );

  if (hover) {
    await hoverHelper(
      tester: tester,
      key: UserEmailDialogKeys.field,
    );
  }

  expect(
    find.byKey(UserEmailDialogKeys.button),
    findsOneWidget,
  );
  //   },
  // );
}
