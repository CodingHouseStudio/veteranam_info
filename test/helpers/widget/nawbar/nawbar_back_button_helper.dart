import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> nawbarBackButtonHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(find.byKey(KWidgetkeys.widget.nawbar.backButton), findsOneWidget);

  await tester.tap(find.byKey(KWidgetkeys.widget.nawbar.backButton));

  await tester.pumpAndSettle();

  verify(
    () => mockGoRouter.pop(),
  ).called(1);
}
