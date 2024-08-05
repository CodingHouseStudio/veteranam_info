import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> nawbarMenuHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(find.byKey(KWidgetkeys.widget.nawbar.menuButton), findsOneWidget);

  await tester.tap(find.byKey(KWidgetkeys.widget.nawbar.menuButton));

  await tester.pumpAndSettle();

  await menuDialogHelper(tester: tester, mockGoRouter: mockGoRouter);
}
