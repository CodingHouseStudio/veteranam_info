import 'package:flutter/widgets.dart' show ScrollPositionAlignmentPolicy;
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_flutter.dart';

import '../../test_dependency.dart';

Future<void> homeFailureHelper(
  WidgetTester tester,
) async {
  await dialogFailureGetTapHelper(tester: tester);

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp500,
    itemKey: HomeKeys.faqTitle,
    scrollPositionAlignmentPolicy:
        ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: HomeKeys.faqSubtitle,
  );

  expect(
    find.byKey(HomeKeys.faqSkeletonizer),
    findsNothing,
  );

  expect(
    find.byKey(HomeKeys.faq),
    findsNothing,
  );

  // await loadingFailureHelper(
  //   tester: tester,
  //   card: HomeKeys.faq,
  //   buttonMock: null,
  // );
}
