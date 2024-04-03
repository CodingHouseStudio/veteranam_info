import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> workCardHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.widgetKeys.workCardKeys.title), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widgetKeys.workCardKeys.city), findsOneWidget);

  expect(
    find.byKey(KWidgetkeys.widgetKeys.workCardKeys.employer),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widgetKeys.workCardKeys.iconSafe),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widgetKeys.workCardKeys.iconShare),
    findsOneWidget,
  );

  expect(find.byKey(KWidgetkeys.widgetKeys.workCardKeys.price), findsOneWidget);

  expect(
    find.byKey(KWidgetkeys.widgetKeys.workCardKeys.button),
    findsOneWidget,
  );

  await cardTextDetailHelper(tester: tester);
}
