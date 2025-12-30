import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/components/mob_faq/view/mob_faq_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../test_dependency.dart';

Future<void> mobFaqPumpAppHelper(
  WidgetTester tester, {
  MockGoRouter? mockGoRouter,
}) async {
  await tester.pumpApp(
    const MobFaqScreen(),
    mockGoRouter: mockGoRouter,
  );

  expect(find.byKey(MobFaqKeys.screen), findsOneWidget);

  await tester.pumpAndSettle();
}
