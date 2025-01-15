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

  expect(find.byKey(ScaffoldKeys.endListText), findsOneWidget);

  expect(find.byKey(ScaffoldKeys.endListButton), findsOneWidget);

  await scrollingHelper(
    tester: tester,
    itemKey: ScaffoldKeys.endListButton,
  );

  await tester.tap(find.byKey(ScaffoldKeys.endListButton));

  await tester.pumpAndSettle();

  expect(find.byKey(ScaffoldKeys.endListText), findsNothing);

  expect(find.byKey(ScaffoldKeys.endListButton), findsNothing);
}
