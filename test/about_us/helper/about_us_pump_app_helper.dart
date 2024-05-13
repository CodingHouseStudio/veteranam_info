import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> aboutUsPumpAppHelper({
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  await tester.pumpApp(const AboutUsScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(KWidgetkeys.screen.aboutUs.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}
