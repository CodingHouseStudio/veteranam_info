import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> workInitialHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(WorkKeys.screen), findsOneWidget);

  expect(
    find.byKey(WorkKeys.boxEmployer),
    findsOneWidget,
  );

  expect(
    find.byKey(WorkKeys.boxEmployee),
    findsOneWidget,
  );

  expect(
    find.byKey(WorkKeys.subtitle),
    findsOneWidget,
  );

  expect(
    find.byKey(WorkKeys.title),
    findsOneWidget,
  );

  // await footerHelper(tester);
}
