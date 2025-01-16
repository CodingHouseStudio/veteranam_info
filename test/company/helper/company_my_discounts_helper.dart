import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> companyMyDiscountsHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      expect(
        find.byKey(CompanyKeys.boxMyDiscounts),
        findsOneWidget,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: CompanyKeys.boxMyDiscounts,
      );

      await tester.tap(find.byKey(CompanyKeys.boxMyDiscounts));

      verify(() => mockGoRouter.goNamed(KRoute.myDiscounts.name)).called(1);
    },
  );
}
