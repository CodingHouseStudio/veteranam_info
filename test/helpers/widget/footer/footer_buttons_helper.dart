import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../../text_dependency.dart';

Future<void> footerButtonsHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  for (var i = 0; i < KWidgetkeys.widget.footer.buttonsKey.length; i++) {
    final buttonKey = KWidgetkeys.widget.footer.buttonsKey.elementAt(i);

    expect(
      find.byKey(buttonKey),
      findsOneWidget,
    );

    await scrollingHelper(tester: tester, itemKey: buttonKey);

    await tester.tap(find.byKey(buttonKey));

    verify(
      () => mockGoRouter.goNamed(
        KAppText.routes.elementAt(i),
      ),
    ).called(1);
  }
}
