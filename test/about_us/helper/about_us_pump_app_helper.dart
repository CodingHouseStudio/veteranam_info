import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/components/about_us/view/about_us_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../test_dependency.dart';

Future<void> aboutUsPumpAppHelper({
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  await tester.pumpApp(const AboutUsScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(AboutUsKeys.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}
