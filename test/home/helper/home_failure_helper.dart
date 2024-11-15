import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_flutter.dart';

import '../../test_dependency.dart';

Future<void> homeFailureHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp250,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.home.faqSubtitle,
  );

  expect(
    find.byKey(KWidgetkeys.screen.home.faqSkeletonizer),
    findsWidgets,
  );

  await loadingFailureHelper(
    tester: tester,
    card: KWidgetkeys.screen.home.faq,
    buttonMock: KWidgetkeys.screen.home.buttonMock,
  );
}
