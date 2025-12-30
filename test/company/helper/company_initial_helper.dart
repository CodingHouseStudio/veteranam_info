import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
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
        find.byKey(CompanyKeys.title),
        findsOneWidget,
      );

      expect(
        find.byKey(CompanyKeys.photo),
        findsOneWidget,
      );

      await companyFormsHelper(tester);

      expect(
        find.byKey(CompanyKeys.logOutButton),
        findsOneWidget,
      );

      expect(
        find.byKey(CompanyKeys.deleteButton),
        findsOneWidget,
      );

      expect(
        find.byKey(CompanyKeys.deleteNotEnabledText),
        findsOneWidget,
      );
    },
  );
}
