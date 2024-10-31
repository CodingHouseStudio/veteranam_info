import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';
import '../../test_mocks/go_router_provider_mocks.dart';

Future<void> boxEmployerNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(KWidgetkeys.screen.work.boxEmployer),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.work.boxEmployer));

  verify(
    () => mockGoRouter.goNamed(KRoute.employer.name),
  ).called(1);
}
