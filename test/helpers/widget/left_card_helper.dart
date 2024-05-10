import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> leftCardHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.widget.leftCard.mob), findsWidgets);

  // expect(find.byKey(KWidgetkeys.widget.leftCard.image), findsNothing);

  expect(find.byKey(KWidgetkeys.widget.leftCard.desk), findsNothing);

  await changeWindowSizeHelper(tester: tester);

  expect(find.byKey(KWidgetkeys.widget.leftCard.mob), findsNothing);

  // expect(find.byKey(KWidgetkeys.widget.leftCard.image), findsNothing);z

  expect(find.byKey(KWidgetkeys.widget.leftCard.desk), findsWidgets);

  await changeWindowSizeHelper(tester: tester, setDefaultSize: true);
}
