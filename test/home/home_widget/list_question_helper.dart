import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> listQuestionHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.home.buttonMock),
    findsNothing,
  );

  // expect(
  //   find.byKey(KWidgetkeys.screen.home.question),
  //   findsOneWidget,
  // );

  // expect(
  //   find.byKey(KWidgetkeys.screen.home.questionList),
  //   findsOneWidget,
  // );

  await scrollingHelper(
    tester: tester,
    itemKey: null,
    offset: KTestConstants.scrollingUp,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: null,
    offset: KTestConstants.scrollingDown500,
  );

  expect(
    find.byKey(KWidgetkeys.screen.home.questionListTitle),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: null,
    offset: KTestConstants.scrollingDown500,
  );

  await questionHelper(tester);
}
