import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../text_dependency.dart';

Future<void> scrollingHelper({
  required WidgetTester tester,
  Offset? offset = KTestConstants.scrollingDown,
  Key? itemKey,
}) async {
  if (offset != null) await tester.drag(find.byType(ListView), offset);
  await tester.pumpAndSettle();
  if (itemKey != null) {
    await tester.ensureVisible(find.byKey(itemKey));
  }
  await tester.pumpAndSettle();
}
