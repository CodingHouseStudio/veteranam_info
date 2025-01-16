import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> nawbarBackButtonHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
  required String routeName,
}) async {
  expect(find.byKey(NawbarKeys.backButton), findsOneWidget);

  await tester.tap(find.byKey(NawbarKeys.backButton));

  await tester.pumpAndSettle();

  verify(
    () => mockGoRouter.goNamed(routeName),
  ).called(1);
}
