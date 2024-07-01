import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> listLoadFilterHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.widget.newsCard.title), findsWidgets);

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

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
  );

  await filterChipHelper(tester);

  // expect(find.byKey(KWidgetkeys.widget.newsCard.title), findsOneWidget);

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  expect(
    find.byKey(KWidgetkeys.widget.scaffold.endListText),
    findsNothing,
  );
}
