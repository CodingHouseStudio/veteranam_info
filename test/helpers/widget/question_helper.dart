import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

Future<void> questionHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.widget.question.widget),
    findsOneWidget,
  );

  expect(find.byKey(KWidgetkeys.widget.question.title), findsOneWidget);

  expect(
    find.byKey(KWidgetkeys.widget.question.subtitle),
    findsNothing,
  );

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widget.question.widget),
      matching: find.byIcon(KIcon.plus.icon!),
    ),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.question.title));

  await tester.pumpAndSettle();

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widget.question.widget),
      matching: find.byIcon(KIcon.minus.icon!),
    ),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.question.subtitle),
    findsOneWidget,
  );
}
