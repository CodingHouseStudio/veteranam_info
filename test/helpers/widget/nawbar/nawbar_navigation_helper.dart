import 'package:flutter_test/flutter_test.dart';

import '../../../text_dependency.dart';

Future<void> navbarNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await nawbarTitleHelper(
    tester: tester,
    mockGoRouter: mockGoRouter,
  );

  await nawbarLoginNavigationHelper(
    tester: tester,
    mockGoRouter: mockGoRouter,
  );
}
