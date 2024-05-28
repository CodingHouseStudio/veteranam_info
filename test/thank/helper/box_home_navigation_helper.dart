import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../test_mocks/go_router_provider_mocks.dart';
import '../../text_dependency.dart';

Future<void> boxHomeNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(KWidgetkeys.screen.thanks.homeBox),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.thanks.homeBox));

  verify(
    () => mockGoRouter.goNamed(KRoute.home.name),
  ).called(1);
}
