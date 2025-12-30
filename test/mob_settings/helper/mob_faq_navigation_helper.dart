import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../test_dependency.dart';

Future<void> mobFaqNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(MobSettingsKeys.faq),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: MobSettingsKeys.faq,
  );

  await tester.tap(find.byKey(MobSettingsKeys.faq));

  await tester.pumpAndSettle();

  verify(
    () => mockGoRouter.goNamed(KRoute.mobFAQ.name),
  ).called(1);
}
