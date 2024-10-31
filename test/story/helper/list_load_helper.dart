import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> listLoadHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.widget.storyCard.userName), findsWidgets);

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  expect(find.byKey(KWidgetkeys.widget.scaffold.endListText), findsNothing);

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  expect(find.byKey(KWidgetkeys.widget.scaffold.endListText), findsNothing);
}
