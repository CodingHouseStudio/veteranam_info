import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/components/profile_saves/profile_saves.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> profileSvaesPumpAppHelper({
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  await tester.pumpApp(
    const ProfileSavesScreen(),
    mockGoRouter: mockGoRouter,
  );

  expect(
    find.byKey(KWidgetkeys.screen.profileSaves.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}
