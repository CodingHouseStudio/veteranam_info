import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/constants/constants.dart';

import '../../../text_dependency.dart';

Future<void> deleteAccountUnconfirmButtonlHelper(
  WidgetTester tester,
  MockGoRouter mockGoRouter,
) async {
  await tester.pumpApp(
    const ProfileScreen(),
    mockGoRouter: mockGoRouter,
  );

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
