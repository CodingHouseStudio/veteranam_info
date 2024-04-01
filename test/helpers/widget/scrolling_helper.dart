import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../text_dependency.dart';

Future<void> scrollingHelper({
  required WidgetTester tester,
  Key? item,
}) async {
  await tester.drag(find.byType(ListView), KTestConstants.scrolling);
  await tester.pumpAndSettle();
  if (item != null) {
    await tester.ensureVisible(find.byKey(item));
  }
  await tester.pumpAndSettle();
}
