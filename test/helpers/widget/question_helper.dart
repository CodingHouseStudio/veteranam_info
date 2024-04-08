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
    KWidgetkeys.widget.question.iconPlus,
    findsOneWidget,
  );

  expect(
    KWidgetkeys.widget.question.iconMinus,
    findsNothing,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.question.title));

  await tester.pumpAndSettle();

  expect(
    KWidgetkeys.widget.question.iconMinus,
    findsOneWidget,
  );

  expect(
    KWidgetkeys.widget.question.iconPlus,
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.question.subtitle),
    findsOneWidget,
  );
}
