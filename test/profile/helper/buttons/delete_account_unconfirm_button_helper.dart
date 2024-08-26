import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> deleteAccountUnconfirmButtonlHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(KWidgetkeys.screen.profile.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();

  await profileCardDeleteAccountHelper(tester);

  await dialogUnconfirmHelper(
    tester: tester,
    mockGoRouter: mockGoRouter,
  );
}
