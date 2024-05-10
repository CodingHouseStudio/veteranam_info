import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> listQuestionHelper(
  WidgetTester tester,
) async {
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
    itemKey: KWidgetkeys.widget.box.text,
    first: false,
  );

  expect(
    find.byKey(KWidgetkeys.screen.home.questionListTitle),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.home.questionListTitle,
  );

  expect(
    find.byKey(KWidgetkeys.screen.home.buttonMock),
    findsNothing,
  );

  await questionHelper(tester);
}
