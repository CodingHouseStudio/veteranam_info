import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../../text_dependency.dart';

Future<void> footerProfileRoutHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await scrollingHelper(
    tester: tester,
    item: KWidgetkeys.footerKeys.profileButton,
  );

  expect(find.byKey(KWidgetkeys.footerKeys.profileButton), findsOneWidget);

  await tester.tap(find.byKey(KWidgetkeys.footerKeys.profileButton));

  verify(
    () => mockGoRouter.go(
      '${KRoute.home.path}${KRoute.profile.path}',
    ),
  ).called(1);
}
