import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> mobSettingsFeedbackHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(KWidgetkeys.screen.mobSettings.feedbackButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.mobSettings.feedbackButton));

  verify(() => mockGoRouter.goNamed(KRoute.feedback.name)).called(1);
}
