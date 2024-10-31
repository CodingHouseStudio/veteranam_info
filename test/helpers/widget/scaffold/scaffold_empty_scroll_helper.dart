import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> scaffoldEmptyScrollHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );
  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  expect(find.byKey(KWidgetkeys.widget.scaffold.endListText), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widget.scaffold.endListButton), findsOneWidget);

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.scaffold.endListButton,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.scaffold.endListButton));

  await tester.pumpAndSettle();

  expect(find.byKey(KWidgetkeys.widget.scaffold.endListText), findsNothing);

  expect(find.byKey(KWidgetkeys.widget.scaffold.endListButton), findsNothing);
}
