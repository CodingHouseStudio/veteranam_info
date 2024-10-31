import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> workCardHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.widget.workCard.title), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widget.workCard.city), findsOneWidget);

  expect(
    find.byKey(KWidgetkeys.widget.workCard.employer),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.workCard.iconSafe),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.workCard.iconShare),
    findsOneWidget,
  );

  expect(find.byKey(KWidgetkeys.widget.workCard.price), findsOneWidget);

  expect(
    find.byKey(KWidgetkeys.widget.workCard.button),
    findsOneWidget,
  );

  await cardTextDetailHelper(tester);
}
