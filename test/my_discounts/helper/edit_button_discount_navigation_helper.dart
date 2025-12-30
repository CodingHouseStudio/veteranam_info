import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/text/url_parameters.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../test_dependency.dart';

Future<void> editButtonDiscountsNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await changeWindowSizeHelper(
    tester: tester,
    test: () async {
      await scrollingHelper(tester: tester, offset: KTestConstants.scrollingUp);

      await scrollingHelper(tester: tester, offset: KTestConstants.scrollingUp);

      expect(
        find.byKey(MyDiscountsKeys.iconEdit),
        findsWidgets,
      );

      await tester.tap(find.byKey(MyDiscountsKeys.iconEdit).first);

      await tester.pumpAndSettle();

      verify(
        () => mockGoRouter.goNamed(
          KRoute.discountsEdit.name,
          pathParameters: {
            UrlParameters.cardId:
                KTestVariables.userDiscountModelItemsWidget.first.id,
          },
          extra: KTestVariables.userDiscountModelItemsWidget.first,
        ),
      ).called(1);
    },
  );
}
