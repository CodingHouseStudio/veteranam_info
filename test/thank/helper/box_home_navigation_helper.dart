import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';
import '../../test_mocks/go_router_provider_mocks.dart';

Future<void> boxHomeNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(ThanksKeys.homeBox),
    findsOneWidget,
  );

  await tester.tap(find.byKey(ThanksKeys.homeBox));

  verify(
    () => mockGoRouter.goNamed(KRoute.home.name),
  ).called(1);
}
