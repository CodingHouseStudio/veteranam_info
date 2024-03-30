import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../../text_dependency.dart';

Future<void> footerInvestorsRoutHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await scrollingHelper(
    tester: tester,
    item: find.byKey(KWidgetkeys.footerKeys.investorsButton),
  );
  expect(find.byKey(KWidgetkeys.footerKeys.investorsButton), findsOneWidget);

  await tester.tap(find.byKey(KWidgetkeys.footerKeys.investorsButton));

  verify(
    () => mockGoRouter.go(
      '${KRoute.home.path}${KRoute.investors.path}',
    ),
  ).called(1);
}
