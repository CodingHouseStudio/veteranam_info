import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../../text_dependency.dart';

Future<void> footerInformationRoutHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.footerKeys.informationButton,
  );

  expect(find.byKey(KWidgetkeys.footerKeys.informationButton), findsOneWidget);

  await tester.tap(find.byKey(KWidgetkeys.footerKeys.informationButton));

  verify(
    () => mockGoRouter.go(
      '${KRoute.home.path}${KRoute.information.path}',
    ),
  ).called(1);
}
