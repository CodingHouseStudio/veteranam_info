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
  );

  for (var i = 0; i < KWidgetkeys.footerKeys.buttonsKey.length; i++) {
    for (var j = 0;
        j < KWidgetkeys.footerKeys.buttonsKey.elementAt(i).length;
        j++) {
      final buttonKey =
          KWidgetkeys.footerKeys.buttonsKey.elementAt(i).elementAt(j);
      final route = KAppText.routes.elementAt(i).elementAt(j);
      await scrollingHelper(
        tester: tester,
        offset: null,
        itemKey: buttonKey,
      );

      expect(
        find.byKey(buttonKey),
        findsOneWidget,
      );

      await tester.tap(find.byKey(buttonKey));
      verify(
        () => mockGoRouter.go(
          route,
        ),
      ).called(1);
    }
  }
}
