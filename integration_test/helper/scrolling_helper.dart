import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import '../constants.dart';

Future<void> scrollingHelper({
  required WidgetTester tester,
  Finder? item,
}) async {
  if (item != null) {
    await tester.ensureVisible(item);
  } else {
    await tester.drag(find.byType(ListView), KTestConstants.scrolling);
  }
  await tester.pumpAndSettle();
}
