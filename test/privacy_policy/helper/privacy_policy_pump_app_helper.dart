import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> privacyPolicyPumpAppHelper({
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  await tester.pumpApp(const PrivacyPolicyDialog(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(KWidgetkeys.screen.privacyPolicy.dialog),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}
