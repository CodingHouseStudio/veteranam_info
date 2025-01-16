import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> listLoadFilterHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(NewsCardKeys.title), findsWidgets);

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  expect(find.byKey(ScaffoldKeys.endListText), findsNothing);

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  expect(find.byKey(ScaffoldKeys.endListText), findsNothing);

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
  );

  await filterChipHelper(tester);

  // expect(find.byKey(NewsCardKeys.title), findsOneWidget);

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  expect(
    find.byKey(ScaffoldKeys.endListText),
    findsNothing,
  );
}
