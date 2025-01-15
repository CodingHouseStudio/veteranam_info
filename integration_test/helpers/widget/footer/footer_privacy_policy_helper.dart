import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> footerPrivacyPolicyHelper(
  WidgetTester tester,
) async {
  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  expect(
    find.byKey(FooterKeys.privacyPolicy),
    findsOneWidget,
  );

  await tester.tap(find.byKey(FooterKeys.privacyPolicy));

  // verify(
  //   () => mockGoRouter.goNamed(
  //     KRoute.privacyPolicy.name,
  //   ),
  // ).called(1);
}
