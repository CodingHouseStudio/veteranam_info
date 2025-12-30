import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../test_dependency.dart';

Future<void> questionHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(QuestionKeys.widget),
    findsWidgets,
  );

  expect(find.byKey(QuestionKeys.title), findsWidgets);

  expect(
    find.byKey(QuestionKeys.subtitle),
    findsNothing,
  );

  expect(
    find.byKey(QuestionKeys.iconPlus),
    findsWidgets,
  );

  expect(
    find.byKey(QuestionKeys.iconMinus),
    findsNothing,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: QuestionKeys.widget,
    scrollPositionAlignmentPolicy:
        ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
  );

  await tester.tap(
    find.byKey(QuestionKeys.widget).first,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(QuestionKeys.iconMinus),
    findsOneWidget,
  );

  expect(
    find.descendant(
      of: find.byKey(QuestionKeys.title).first,
      matching: find.byKey(QuestionKeys.iconPlus),
    ),
    findsNothing,
  );

  expect(
    find.byKey(QuestionKeys.subtitle),
    findsOneWidget,
  );

  await tester.tap(find.byKey(QuestionKeys.title).first);

  await tester.pumpAndSettle();

  expect(
    find.byKey(QuestionKeys.iconMinus),
    findsNothing,
  );

  expect(
    find.byKey(QuestionKeys.subtitle),
    findsNothing,
  );
}
