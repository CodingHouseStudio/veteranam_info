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

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  await changeWindowSizeHelper(
    tester: tester,
    test: () async {
      for (var i = KWidgetkeys.widget.footer.buttonsKey.length - 1;
          i >= 0;
          i--) {
        final buttonKey = KWidgetkeys.widget.footer.buttonsKey.elementAt(i);

        expect(
          find.byKey(buttonKey),
          findsOneWidget,
        );

        await tester.tap(find.byKey(buttonKey));

        verify(
          () => mockGoRouter.goNamed(
            KAppText.routes(hasAccount: false).elementAt(i),
          ),
        ).called(1);
      }
    },
  );
}
