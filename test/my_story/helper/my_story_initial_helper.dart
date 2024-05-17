import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

//import '../../text_dependency.dart';

Future<void> employerInitialHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.myStory.title),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.myStory.subtitle),
    findsOneWidget,
  );

  // await scrollingHelper(
  //   tester: tester,
  //   itemKey: KWidgetkeys.screen.myStory.subtitle,
  // );

  //await storyCardHelper(tester: tester);
}
