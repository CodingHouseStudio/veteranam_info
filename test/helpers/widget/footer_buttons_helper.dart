import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../text_dependency.dart';

Future<void> footerButtonsHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
    itemKey: null,
  );

  for (var i = 0; i < KWidgetkeys.widget.footer.buttonsKey.length; i++) {
    for (var j = 0;
        j < KWidgetkeys.widget.footer.buttonsKey.elementAt(i).length;
        j++) {
      final buttonKey =
          KWidgetkeys.widget.footer.buttonsKey.elementAt(i).elementAt(j);
      await scrollingHelper(
        tester: tester,
        itemKey: buttonKey,
      );

      expect(
        find.byKey(buttonKey),
        findsOneWidget,
      );

      await tester.tap(find.byKey(buttonKey));

      verify(
        () => mockGoRouter.go(
          KAppText.routes.elementAt(i).elementAt(j),
        ),
      ).called(1);
    }
  }
}
