import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> workCardHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.widget.workCard.title), findsWidgets);

  expect(find.byKey(KWidgetkeys.widget.workCard.city), findsWidgets);

  expect(
    find.byKey(KWidgetkeys.widget.workCard.employer),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.workCard.iconSafe),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.workCard.iconShare),
    findsWidgets,
  );

  expect(find.byKey(KWidgetkeys.widget.workCard.price), findsWidgets);

  expect(
    find.byKey(KWidgetkeys.widget.workCard.button),
    findsWidgets,
  );

  await cardTextDetailHelper(tester: tester);
}
