import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../../text_dependency.dart';

Future<void> footerDiscountsRoutHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await scrollingHelper(
    tester: tester,
  );
  await scrollingHelper(
    tester: tester,
    item: find.byKey(KWidgetkeys.footerKeys.discountsButton),
  );

  expect(find.byKey(KWidgetkeys.footerKeys.discountsButton), findsOneWidget);

  await tester.tap(find.byKey(KWidgetkeys.footerKeys.discountsButton));

  verify(
    () => mockGoRouter.go(
      '${KRoute.home.path}${KRoute.discounts.path}',
    ),
  ).called(1);
}
