import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> profileSavesInitialHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.profileSaves.title),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.profileSaves.subtitle),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.profileSaves.discountCard),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.profileSaves.workCard),
    findsOneWidget,
  );
  await workCardHelper(tester);
}
