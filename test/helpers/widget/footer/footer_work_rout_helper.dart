import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../../text_dependency.dart';

Future<void> footerWorkRoutHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await scrollingHelper(
    tester: tester,
    item: KWidgetkeys.footerKeys.workButton,
  );

  expect(find.byKey(KWidgetkeys.footerKeys.workButton), findsOneWidget);

  await tester.tap(find.byKey(KWidgetkeys.footerKeys.workButton));

  verify(
    () => mockGoRouter.go(
      '${KRoute.home.path}${KRoute.work.path}',
    ),
  ).called(1);
}
