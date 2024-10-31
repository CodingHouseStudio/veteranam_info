import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> workInitialHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.screen.work.screen), findsOneWidget);

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

  // await footerHelper(tester);
}
