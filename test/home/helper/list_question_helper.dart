import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> listQuestionHelper(
  WidgetTester tester,
) async {
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

  expect(
    find.byKey(KWidgetkeys.screen.home.questions),
    findsOneWidget,
  );

  await questionHelper(tester);
}
