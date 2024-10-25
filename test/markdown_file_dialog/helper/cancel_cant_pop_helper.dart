import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> cancelCanNotPopHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
  required bool business,
}) async {
  expect(
    find.byKey(KWidgetkeys.screen.privacyPolicy.closeIcon),
    findsWidgets,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.privacyPolicy.closeIcon));
  if (business) {
    verify(
      () => mockGoRouter.goNamed(KRoute.discountsAdd.name),
    ).called(1);
  } else {
    verify(
      () => mockGoRouter.goNamed(KRoute.home.name),
    ).called(1);
  }
}
