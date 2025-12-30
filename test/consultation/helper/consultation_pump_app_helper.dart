import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/components/consultation/view/consultation_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../test_dependency.dart';

Future<void> consultationPumpAppHelper({
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  await tester.pumpApp(
    const ConsultationScreen(),
    mockGoRouter: mockGoRouter,
  );

  expect(
    find.byKey(ConsultationKeys.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}
