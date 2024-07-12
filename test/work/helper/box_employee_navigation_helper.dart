import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_mocks/go_router_provider_mocks.dart';
import '../../text_dependency.dart';

Future<void> boxEmployeeNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(KWidgetkeys.screen.work.boxEmployee),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.work.boxEmployee));

  verify(
    () => mockGoRouter.goNamed(KRoute.workEmployee.name),
  ).called(1);
}
