import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

Future<void> footerStoryRoutHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.footerKeys.storyButton), findsOneWidget);

  await tester.tap(find.byKey(KWidgetkeys.footerKeys.storyButton));

  await tester.pumpAndSettle();
}
