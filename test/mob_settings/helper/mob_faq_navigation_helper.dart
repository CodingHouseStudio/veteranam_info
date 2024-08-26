import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> mobFaqNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(KWidgetkeys.screen.mobSettings.faq),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.mobSettings.faq,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.mobSettings.faq));

  await tester.pumpAndSettle();

  verify(
    () => mockGoRouter.goNamed(KRoute.mobFAQ.name),
  ).called(1);
}
