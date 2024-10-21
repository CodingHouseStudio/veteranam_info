import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> editButtonDiscountsNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(KWidgetkeys.screen.myDiscounts.iconEdit),
    findsWidgets,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.myDiscounts.iconEdit).first);

  await tester.pumpAndSettle();

  verify(
    () => mockGoRouter.goNamed(
      KRoute.discountsEdit.name,
      pathParameters: {
        UrlParameters.cardId: KTestText.discountModelItems.first.id,
      },
      extra: KTestText.discountModelItems.first,
    ),
  ).called(1);
}
