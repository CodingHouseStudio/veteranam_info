import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> workInitialHelper(
  WidgetTester tester,
) async {
  await nawbarHelper(tester: tester, searchText: KTestText.field);

  expect(
    find.byKey(KWidgetkeys.screen.work.boxEmployer),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.work.boxEmployee),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.work.subtitle),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.work.title),
    findsOneWidget,
  );

  await footerHelper(tester);
}
