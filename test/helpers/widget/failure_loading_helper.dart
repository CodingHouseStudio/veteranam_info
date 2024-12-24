import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_dependency.dart';

Future<void> loadingFailureHelper({
  required WidgetTester tester,
  required Key card,
  required Key? buttonMock,
  bool hasShimmer = false,
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

  await dialogSnackBarTextHelper(tester: tester);
}
