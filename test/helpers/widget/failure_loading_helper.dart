import 'package:flutter/foundation.dart';

import 'package:flutter_test/flutter_test.dart';

import '../../test_dependency.dart';

Future<void> loadingFailureHelper({
  required WidgetTester tester,
  required Key card,
  required Key? buttonMock,
  bool hasShimmer = false,
  bool containTapButton = false,
}) async {
  if (!hasShimmer) {
    expect(
      find.byKey(card),
      findsNothing,
    );
  }

  if (buttonMock != null) {
    expect(
      find.byKey(buttonMock),
      findsNothing,
    );
  }

  if (containTapButton) {
    await dialogFailureGetTapHelper(tester: tester);
  } else {
    await dialogFailureGetHelper(tester: tester);
  }
}
