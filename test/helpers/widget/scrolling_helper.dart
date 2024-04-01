import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../text_dependency.dart';

Future<void> scrollingHelper({
  required WidgetTester tester,
  Offset? offset = KTestConstants.scrollingDown,
  Key? item,
}) async {
  if (offset != null) await tester.drag(find.byType(ListView), offset);
  await tester.pumpAndSettle();
  if (item != null) {
    await tester.ensureVisible(find.byKey(item));
  }
  await tester.pumpAndSettle();
}
