import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

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
}
