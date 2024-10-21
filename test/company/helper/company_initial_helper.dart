import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';
import 'helper.dart';

Future<void> companyInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      expect(
        find.byKey(KWidgetkeys.screen.company.title),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.company.photo),
        findsOneWidget,
      );

      await companyFormsHelper(tester);

      expect(
        find.byKey(KWidgetkeys.screen.company.logOutButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.company.deleteButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.company.deleteNotEnabledText),
        findsOneWidget,
      );
    },
  );
}
