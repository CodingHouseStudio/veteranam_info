import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/components/news_card/view/news_card_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> newsCardPumpAppHelper(
  WidgetTester tester, {
  MockGoRouter? mockGoRouter,
}) async {
  await tester.pumpApp(
    NewsCardDialog(id: KTestVariables.informationModelItems.first.id),
    mockGoRouter: mockGoRouter,
  );

  expect(
    find.byKey(NewsCardDialogKeys.dialog),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}
