import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../text_dependency.dart';

Future<void> logOutConfirmButtonlHelper(
  WidgetTester tester,
  MockGoRouter mockGoRouter,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.profile.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();

  await profileCardLogOutHelper(tester);

  await dialogConfirmHelper(
    tester: tester,
    mockGoRouter: mockGoRouter,
  );
}
