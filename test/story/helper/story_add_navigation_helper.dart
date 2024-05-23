import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../test_mocks/go_router_provider_mocks.dart';
import '../../text_dependency.dart';

Future<void> storyAddNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(KWidgetkeys.screen.story.seccondaryButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.story.seccondaryButton));

  verify(
    () => mockGoRouter.goNamed(KRoute.storyAdd.name),
  ).called(1);
}
