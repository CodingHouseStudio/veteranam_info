import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> discountsEditIdWrongNavHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(KWidgetkeys.screen.discountsAdd.buttonWrongLink),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.discountsAdd.buttonWrongLink));

  await tester.pumpAndSettle();

  verify(
    () => mockGoRouter.goNamed(KRoute.myDiscounts.name),
  ).called(1);
}