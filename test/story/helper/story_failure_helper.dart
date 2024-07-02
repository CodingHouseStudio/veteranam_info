import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> storyFailureHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.story.card),
    findsNothing,
  );

  await dialogFailureGetTapHelper(tester: tester);
}
