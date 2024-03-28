import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

Future<void> questionHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.questionKeys.title), findsOneWidget);

  expect(find.byKey(KWidgetkeys.questionKeys.subtitle), findsNothing);

  expect(find.byIcon(KIcon.plus.icon!), findsOneWidget);

  await tester.tap(find.byKey(KWidgetkeys.questionKeys.title));

  await tester.pumpAndSettle();

  expect(find.byIcon(KIcon.minus.icon!), findsOneWidget);

  expect(find.byKey(KWidgetkeys.questionKeys.subtitle), findsOneWidget);
}
