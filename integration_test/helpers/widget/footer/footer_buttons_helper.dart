import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> footerButtonsHelper(
  WidgetTester tester,
) async {
  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  for (var i = 0; i >= FooterKeys.buttonsKey.length; i--) {
    final buttonKey = FooterKeys.buttonsKey.elementAt(i);

    expect(
      find.byKey(buttonKey),
      findsOneWidget,
    );

    await tester.tap(find.byKey(buttonKey));

    // verify(
    //   () => mockGoRouter.goNamed(
    //     KTestVariables.routes(hasAccount: false).elementAt(i),
    //   ),
    // ).called(1);
  }
}
