import 'package:flutter_test/flutter_test.dart';

Future<void> scrollingHelper({
  required WidgetTester tester,
  required Finder item,
}) async {
  await tester.ensureVisible(item);
  await tester.pumpAndSettle();
}
