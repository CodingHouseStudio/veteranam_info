import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> myDiscountHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      expect(
        find.byKey(KWidgetkeys.screen.discounts.addDiscountButton),
        findsOneWidget,
      );

      await tester
          .tap(find.byKey(KWidgetkeys.screen.discounts.addDiscountButton));

      verify(() => mockGoRouter.goNamed(KRoute.myDiscounts.name)).called(1);
    },
  );
}
