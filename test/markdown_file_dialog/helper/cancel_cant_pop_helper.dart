import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> cancelCanNotPopHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
  required bool business,
}) async {
  expect(
    find.byKey(PrivacyPolicyDialogKeys.closeIcon),
    findsWidgets,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: PrivacyPolicyDialogKeys.closeIcon,
  );

  await tester.tap(find.byKey(PrivacyPolicyDialogKeys.closeIcon));

  await tester.pumpAndSettle();

  if (business) {
    verify(
      () => mockGoRouter.goNamed(KRoute.feedback.name),
    ).called(1);
  } else {
    verify(
      () => mockGoRouter.goNamed(KRoute.home.name),
    ).called(1);
  }
}
